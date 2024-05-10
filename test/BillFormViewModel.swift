
//  BillFormViewModel.swift
//  test
//
//  Created by admin on 29/04/24.
//


import SwiftUI
import FirebaseFirestore

import Foundation

class BillFormViewModel: ObservableObject {
    @Published var bill: Bill
    @Published var items: [BillItem] = []

    private let services = Services.shared
    
    init() {
        self.bill = Bill(id: UUID(),
                         creationTimestamp: Date(),
                         hospitalName: "MedNex",
                         hospitalAddress: "India",
                         hospitalContactInfo: "9876543210",
                         patientID: "",
                         doctorID: "",
                         billingDate: Date(),
                         items: [],
                         totalAmountDue: nil,
                         amountPaid: nil,
                         paymentMethod: "COD",
                         paymentDate: Date(),
                         outstandingBalance: nil,
                         notes: "",
                         discountsOrAdjustments: nil,
                         taxes: 0.36,
                         referralInfo: nil)
    }
    
    func updateTotalAmountDue() {
        var totalAmountDue: Double = 0.0
        
        for item in items {
            if let quantity = item.quantity, let pricePerService = item.pricePerService {
                totalAmountDue += Double(quantity) * pricePerService
            }
        }
        
        bill.totalAmountDue = totalAmountDue
    }
    
    
    func saveBill() {
        
        services.saveBill(bill, items: items)

        self.bill = Bill(id: UUID(),
                         creationTimestamp: Date(),
                         hospitalName: "MedNex",
                         hospitalAddress: "India",
                         hospitalContactInfo: "9876543210",
                         patientID: "",
                         doctorID: "",
                         billingDate: Date(),
                         items: [],
                         totalAmountDue: nil,
                         amountPaid: nil,
                         paymentMethod: "COD",
                         paymentDate: Date(),
                         outstandingBalance: nil,
                         notes: "",
                         discountsOrAdjustments: nil,
                         taxes: 0.36,
                         referralInfo: nil)
        
    }

    func addItem() {
        items.append(BillItem(id: UUID(), description: "", quantity: 0, pricePerService: 0, totalCharge: 0.0))
    }
}
