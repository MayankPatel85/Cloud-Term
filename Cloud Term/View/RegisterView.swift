//
//  RegisterView.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-15.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var password: String = ""
    @State private var isRegisterAccount: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("SNKRS")
                .font(.system(size: 64, weight: .heavy))
            
            Spacer()
            
            HStack {
                TextField("Enter your email", text: $email)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(style: .init())
            )
            
            HStack {
                SecureField("Enter your password", text: $password)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(style: .init())
            )
            .padding(.top, 20)
            
            Button {
                
            } label: {
                HStack {
                    Text("LOGIN")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.vertical, 20)
            }
            
            HStack {
                Text("Don't have an account")
                
                Spacer()
                
                Button("Register") {
                    isRegisterAccount.toggle()
                }
            }
            
        }
        .padding()
        .background(Color("BGColor"))
        .fullScreenCover(isPresented: $isRegisterAccount) {
            RegisterView()
        }

    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
