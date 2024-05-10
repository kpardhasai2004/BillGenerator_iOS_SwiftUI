////
////  BillListView.swift
////  test
////
////  Created by admin on 03/05/24.
////
//
//import SwiftUI
//
//struct BillListView: View {
//    @ObservedObject var viewModel: BillViewModel
//    
//    var body: some View {
//        NavigationView {
//            
//            for bill in viewModel.bills {
//                fetchBillItems(forBillID: bill.id) { billItem in
//                    viewModel.billItems.append(billItem)
//                }
//            }
//
//            
//            List(viewModel.bills) { bill in // Remove the id: \.id argument
//                Section(header: Text("Bill ID: \(bill.id.uuidString)")) {
//                    Text("Hospital Name: \(bill.hospitalName)")
//                    Text("Patient ID: \(bill.patientID)")
//                    
//                    Section(header: Text("Bill Items")) {
//                        ForEach(bill.billItems, id: \.id) { item in
//                            VStack(alignment: .leading) {
//                                Text("Description: \(item.description)")
//                                Text("Quantity: \(item.quantity ?? 0)")
//                                Text("Price Per Service: \(item.pricePerService ?? 0.0)")
//                                Text("Total Charge: \(item.totalCharge ?? 0.0)")
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationTitle("All Bills")
//        }
//    }
//}
//
//
