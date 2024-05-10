//
//  loginView.swift
//  test
//
//  Created by admin on 23/04/24.
//

import SwiftUI
struct CustomTextField: View {
    @State var text: String = " "
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Search", text: $text)
                    TextField("Search", text: $text)
                }.underlineTextField()
            }.padding()
        }
    }
}

#Preview {
    CustomTextField(text: "text")
}

struct loginView: View {
    var body: some View {
        ZStack{
            
            Color.solitude.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                // Logo (caduceus symbol)
    //            Image(systemName: "staroflife")
    //                .font(.largeTitle)
    //                .padding()
    //
    //            // App Name
    //            Text("MEDNEX")
    //                .font(.title)
    //                .bold()
    //
    //            Text("HEALTH")
    //                .font(.title)
    //                .bold()
                
                
                
                
                // Sign Up Button
                Button(action: {
                    // Handle sign-up action
                }) {
                    Text("Sign up")
                        .foregroundColor(.white)
                        .padding(.horizontal, 100)
                        .padding()
                        .background(Color.midNightExpress)
                        .cornerRadius(10)
                }

                // Already have an account? Sign in
                HStack{
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                        .padding(.top)
                    
                    Text("Sign in")
                        .foregroundColor(.asparagus)
                        .padding(.top)
                }
                
            }
            .padding()
        }
    }
}


extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.blue)
            .padding(10)
    }
}
