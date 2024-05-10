//
//  AllBillsView.swift
//  test
//
//  Created by admin on 03/05/24.
//
import SwiftUI

struct AllBillsView: View {
    @ObservedObject var viewModel: BillViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.billsWithItems, id: \.bill.id) { billWithItems in
                NavigationLink(destination: BillDetailView(bill: billWithItems.bill, items: billWithItems.items)) {
                    VStack(alignment: .leading) {
                        Text("Hospital: \(billWithItems.bill.hospitalName)")
                            .font(.headline)
                        Text("Patient ID: \(billWithItems.bill.patientID)")
                            .font(.subheadline)
                        
                        ForEach(billWithItems.items, id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text("Description: \(item.description)")
                                    .font(.subheadline)
                                Text("Quantity: \(item.quantity ?? 0)")
                                    .font(.caption)
                                Text("Price Per Service: \(item.pricePerService ?? 0.0, specifier: "%.2f")")
                                    .font(.caption)
                                Text("Total Charge: \(item.totalCharge ?? 0.0, specifier: "%.2f")")
                                    .font(.caption)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("All Bills")
        }
    }
}

