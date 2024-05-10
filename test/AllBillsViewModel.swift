////
////  AllBillsViewModel.swift
////  test
////
////  Created by admin on 03/05/24.
////
//
//import FirebaseFirestore
//import Combine
//
//
//class AllBillsViewModel: ObservableObject {
//    private let services = Services.shared
//    private var cancellables: Set<AnyCancellable> = []
//    
//    @Published var bills: [Bill] = []
//    @Published var billItems: [String: [BillItem]] = [:] // Dictionary to hold bill items for each bill
//    
//    var sortedBills: [Bill] {
//        return bills.sorted(by: { $0.billingDate < $1.billingDate })
//    }
//    
//    func fetchBills() {
//        services.fetchBills { fetchedBills in
//            self.bills = fetchedBills
//            // Fetch bill items for each bill
//            for bill in fetchedBills {
//                self.fetchBillItems(for: bill.id.uuidString) // Pass the bill ID as String
//            }
//        }
//    }
//    
//    func fetchBillItems(for billID: String) { // Modify the function parameter to take a String
//        services.fetchBillItems(for: billID) { fetchedItems in // Pass the billID to fetchBillItems
//            self.billItems[billID] = fetchedItems // Store fetched items in the dictionary with billID as key
//        }
//    }
//    
//    func updateBill(_ bill: Bill) {
//        services.updateBill(bill)
//    }
//}
//
//
