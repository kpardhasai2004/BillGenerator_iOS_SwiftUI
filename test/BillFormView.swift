import SwiftUI
import Combine

struct BillFormView: View {
    @ObservedObject var viewModel: BillFormViewModel
    
    var body: some View {
        NavigationView {
            Form {
                hospitalSection
                patientSection
                serviceDetailsSection
                paymentDetailsSection
                saveButton
            }
            .navigationTitle("New Bill")
            .scrollContentBackground(.hidden)
            .background(Color.solitude)
        }
    }
    
    private var hospitalSection: some View {
        Section(header: Text("Hospital Information")) {
            TextField("Hospital Name", text: $viewModel.bill.hospitalName)
                .underlineTextField()
            TextField("Hospital Address", text: $viewModel.bill.hospitalAddress)
                .underlineTextField()
            TextField("Hospital Contact Info", text: $viewModel.bill.hospitalContactInfo)
                .underlineTextField()

        }
        .listRowBackground(Color.solitude)
    }
    
    private var patientSection: some View {
        Section(header: Text("Patient Information")) {
            TextField("Patient ID", text: $viewModel.bill.patientID)
                .underlineTextField()

            TextField("Doctor ID", text: $viewModel.bill.doctorID)
                .underlineTextField()

        }
        .listRowBackground(Color.solitude)
    }
    
    private var serviceDetailsSection: some View {
        Section(header: Text("Service Details")) {
            DatePicker("Billing Date", selection: $viewModel.bill.billingDate, displayedComponents: .date)
            ForEach(viewModel.items.indices, id: \.self) { index in
                VStack {
                    HStack {
                        TextField("Name of the item", text: $viewModel.items[index].description)
                            .underlineTextField()
                        Spacer()
                        Button(action: {
                            viewModel.items.remove(at: index)
                        }) {
                            Image(systemName: "multiply.circle")
                                .foregroundColor(.red)
                        }
                    }
                    VStack {
                        HStack {
                            Text("Quantity :")
                            TextField("Quantity", text: Binding(
                                get: { String(viewModel.items[index].quantity ?? 0) },
                                set: { newValue in
                                    viewModel.items[index].quantity = Int(newValue) ?? 0
                                    calculateTotalCharge(for: index)
                                }
                            ))
                            .keyboardType(.numberPad)
                            .underlineTextField()

                        }
                        HStack {
                            Text("Price Per Service :")
                            TextField("Price Per Service", text: Binding(
                                get: { viewModel.items[index].pricePerService == 0 ? "0" : String(viewModel.items[index].pricePerService ?? 0) },
                                set: { newValue in
                                    viewModel.items[index].pricePerService = Double(newValue) ?? 0.0
                                    calculateTotalCharge(for: index)
                                }
                            ))
                            .keyboardType(.decimalPad)
                            .underlineTextField()

                        }
                        HStack {
                            Text("Total Charge: \(viewModel.items[index].totalCharge ?? 0.0, specifier: "%.2f")")
                            Spacer()
                        }
                    }
                }
            }
            VStack {
                Button(action: {
                    viewModel.addItem()
                }) {
                    Text("Add Item")
                }
                Spacer()
            }
            VStack{
                Button(action: {
                    viewModel.updateTotalAmountDue()
                }) {
                    Text("Done")
                }
            }
            HStack {
                Text("Total Amount Due:")
                Spacer()
                Text("\(viewModel.bill.totalAmountDue ?? 0.0, specifier: "%.2f")")
            }
        }
        .listRowBackground(Color.solitude)
    }
    
    private var paymentDetailsSection: some View {
        Section(header: Text("Payment Details")) {
            HStack{
                Text("Total Amount Due:")
                TextField("Total Amount Due", text: Binding(
                    get: { String(viewModel.bill.totalAmountDue ?? 0.0) },
                    set: { viewModel.bill.totalAmountDue = Double($0) ?? 0.0 }
                ))
                .keyboardType(.decimalPad)
            }
            
            HStack{
                Text("Amount Paid:")
                TextField("Amount Paid", text: Binding(
                    get: { String(viewModel.bill.amountPaid ?? 0.0) },
                    set: { newValue in
                        viewModel.bill.amountPaid = Double(newValue) ?? 0.0
                        let totalAmountDue = viewModel.bill.totalAmountDue ?? 0.0
                        let amountPaid = Double(newValue) ?? 0.0
                        viewModel.bill.outstandingBalance = totalAmountDue - amountPaid
                    }
                ))
                .underlineTextField()
                .keyboardType(.decimalPad)
            }
            
            HStack{
                Text("Outstanding Balance:")
                TextField("Outstanding Balance", text: Binding(
                    get: { String(viewModel.bill.outstandingBalance ?? 0.0) },
                    set: { newValue in
                        viewModel.bill.outstandingBalance = Double(newValue) ?? 0.0
                    }
                ))
                .keyboardType(.decimalPad)
                .disabled(true)
            }
            
            HStack{
                Text("Payment Method:")
                TextField("Payment Method", text: $viewModel.bill.paymentMethod)
            }
            DatePicker("Payment Date", selection: $viewModel.bill.paymentDate, displayedComponents: .date)
        }
        .listRowBackground(Color.solitude)
    }
    
    private var saveButton: some View {
        Button("Save") {
            viewModel.saveBill()
            viewModel.bill.items.removeAll()
            viewModel.items.removeAll()
        }
    }
    
    private func calculateTotalCharge(for index: Int) {
        let quantity = viewModel.items[index].quantity ?? 0
        let pricePerService = viewModel.items[index].pricePerService ?? 0.0
        viewModel.items[index].totalCharge = Double(quantity) * pricePerService
    }
}

struct BillFormView_Previews: PreviewProvider {
    static var previews: some View {
        BillFormView(viewModel: BillFormViewModel())
    }
}



//
//import SwiftUI
//import Combine
//
//struct BillFormView: View {
//    @StateObject var viewModel: BillFormViewModel
//    @StateObject var viewModel1: BillViewModel
//    
//    @State private var applyDiscountsOrAdjustments = false
//    @State private var discountOrAdjustmentAmount: Double = 0.0
//    
//    var totalAmountDue: Double {
//        return viewModel.items.reduce(0) { $0 + ($1.totalCharge ?? 0) }
//    }
//
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Hospital Information")) {
//                    TextField("Hospital Name", text: $viewModel.bill.hospitalName)
//                    TextField("Hospital Address", text: $viewModel.bill.hospitalAddress)
//                    TextField("Hospital Contact Info", text: $viewModel.bill.hospitalContactInfo)
//                }
//                
//                Section(header: Text("Patient Information")) {
//                    TextField("Patient ID", text: $viewModel.bill.patientID)
//                    TextField("Doctor ID", text: $viewModel.bill.doctorID)
//                }
//                
//                Section(header: Text("Service Details")) {
//                    DatePicker("Billing Date", selection: $viewModel.bill.billingDate, displayedComponents: .date)
//                    
//                    ForEach(viewModel.items.indices, id: \.self) { index in
//                        VStack {
//                            HStack{
//                                TextField("Name of the item", text: $viewModel.items[index].description)
//                                Spacer()
//                                Button(action: {
//                                    viewModel.items.remove(at: index)
//                                }) {
//                                    Image(systemName: "multiply.circle")
//                                        .foregroundColor(.red)
//                                }
//
//                            }
//                            HStack{
//                                TextField("Quantity", value: $viewModel.items[index].quantity, formatter: NumberFormatter())
//                                    .keyboardType(.numberPad)
//                                TextField("Price Per Service", value: $viewModel.items[index].pricePerService, formatter: NumberFormatter())
//                                    .keyboardType(.decimalPad)
//                            }
//                        }
//                    }
//
//                    // Button to add new item
//                    Button(action: {
//                        viewModel.addItem()
//                    }) {
//                        Text("Add Item")
//                    }
//                    
//                    HStack {
//                        Text("Total Amount Due:")
//                        Spacer()
//                        Text("\(totalAmountDue, specifier: "%.2f")")
//                    }
//                    
////                    HStack {
////                        Toggle("Apply Discounts or Adjustments", isOn: $applyDiscountsOrAdjustments)
////                            .onChange(of: applyDiscountsOrAdjustments) { value in
////                                if !value {
////                                    discountOrAdjustmentAmount = 0.0
////                                }
////                            }
////                        if applyDiscountsOrAdjustments {
////                            TextField("Discount or Adjustment Amount", value: $discountOrAdjustmentAmount, formatter: NumberFormatter())
////                                .keyboardType(.decimalPad)
////                        }
////                    }
////                    
////                    Button(action: {
////                        viewModel.addItem()
////                    }) {
////                        Text("Add Item")
////                    }
//                    
//                }
//                
//                Section(header: Text("Payment Details")) {
//                    TextField("Total Amount Due", value: $viewModel.bill.totalAmountDue, formatter: NumberFormatter())
//                        .keyboardType(.decimalPad)
//                    TextField("Amount Paid", value: $viewModel.bill.amountPaid, formatter: NumberFormatter())
//                        .keyboardType(.decimalPad)
//                    TextField("Payment Method", text: $viewModel.bill.paymentMethod)
//                    DatePicker("Payment Date", selection: $viewModel.bill.paymentDate, displayedComponents: .date)
//                    TextField("Outstanding Balance", value: $viewModel.bill.outstandingBalance, formatter: NumberFormatter())
//                        .keyboardType(.decimalPad)
//                }
//                
//                Button("Save") {
//                    viewModel.saveBill(viewModel.bill)
//                }
//            }
//            .navigationTitle("New Bill")
//        }
//    }
//}

//struct BillFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        BillFormView(viewModel: BillFormViewModel(), viewModel1: BillViewModel())
//    }
//}
