//
//  BillDetailView.swift
//  test
//
//  Created by admin on 03/05/24.
//

import SwiftUI

struct BillDetailView: View {
    let bill: Bill
    let items: [BillItem]
    
    var body: some View {
        List {
            Section(header: Text("Hospital Information")) {
                Text("Name: \(bill.hospitalName)")
                Text("Address: \(bill.hospitalAddress)")
                Text("Contact Info: \(bill.hospitalContactInfo)")
            }
            
            Section(header: Text("Patient Information")) {
                Text("ID: \(bill.patientID)")
                Text("Doctor ID: \(bill.doctorID)")
            }
            
            Section(header: Text("Service Details")) {
                Text("Billing Date: \(formattedDate)")
                
                ForEach(items, id: \.id) { item in
                    VStack(alignment: .leading) {
                        Text("Description: \(item.description)")
                        Text("Quantity: \(item.quantity ?? 0)")
                        Text("Price Per Service: \(item.pricePerService ?? 0.0, specifier: "%.2f")")
                        Text("Total Charge: \(item.totalCharge ?? 0.0, specifier: "%.2f")")
                    }
                }
                
                
                
                Text("Total Amount Due: \(bill.totalAmountDue ?? 0.0, specifier: "%.2f")")
            }
            
            Section(header: Text("Payment Details")) {
                Text("Amount Paid: \(bill.amountPaid ?? 0.0, specifier: "%.2f")")
                Text("Outstanding Balance: \(bill.outstandingBalance ?? 0.0, specifier: "%.2f")")
                Text("Payment Method: \(bill.paymentMethod)")
                Text("Payment Date: \(bill.paymentDate, formatter: dateFormatter)")
            }
        }
        .background(Color.blue)
        .navigationTitle("Bill Details")
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: bill.billingDate)
    }
}
