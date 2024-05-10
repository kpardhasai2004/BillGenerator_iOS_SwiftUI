//
//  ContentView.swift
//  test
//
//  Created by admin on 23/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @StateObject private var viewModel = BillFormViewModel()
    @StateObject private var viewModel1 = BillViewModel()
    
    var body: some View {
        NavigationStack{
            BillFormView(viewModel: viewModel)
            
            NavigationLink(destination : AllBillsView(viewModel: BillViewModel())) {
                Text("all bills")
            }
            

            
        }
    }
}

#Preview {
    ContentView()
}
