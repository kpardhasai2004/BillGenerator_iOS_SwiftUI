//
//  BillViewModel.swift
//  test
//
//  Created by admin on 03/05/24.
//

import Foundation
import FirebaseFirestore
import Combine

class BillViewModel: ObservableObject {
    @Published var bills: [Bill] = []
    @Published var billItems: [BillItem] = []
    @Published var billsWithItems: [(bill: Bill, items: [BillItem])] = []

    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchBillsWithItems()
//        fetchBills()
    }
    
    func fetchBillsWithItems() {
        db.collection("bills").addSnapshotListener { [weak self] querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
        
            
            var billsWithItems: [(bill: Bill, items: [BillItem])] = []
            
            for document in documents {
                if let bill = try? document.data(as: Bill.self) {
                    let billID = document.documentID
                    self?.fetchBillItems(for: billID) { billItems in
                        billsWithItems.append((bill, billItems))
                        self?.billsWithItems = billsWithItems
                    }
                }
            }
        }
    }
    
    func fetchBillItems(for billID: String, completion: @escaping ([BillItem]) -> Void) {
        db.collection("bills").document(billID).collection("billItems").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching bill items: \(error!)")
                completion([])
                return
            }
            
            let billItems = documents.compactMap { document -> BillItem? in
                try? document.data(as: BillItem.self)
            }
            completion(billItems)
        }
    }
}

