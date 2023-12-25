//
//  LoginView.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-15.
//

import SwiftUI
import FirebaseAuth

struct AuthenticationView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRegisterAccount: Bool = false
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("SNKRS")
                .font(.system(size: 64, weight: .heavy))
            
            Spacer()
            
            HStack {
                TextField("Enter your email", text: $email)
                    .textInputAutocapitalization(.never)
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
                if isRegisterAccount {
                    authViewModel.register(email: email, password: password)
                    Task {
                        await authViewModel.subscribeEmail(email: email)
                    }
                } else {
                    authViewModel.signIn(email: email, password: password)
                    Task {
                        await authViewModel.subscribeEmail(email: email)
                    }
                }
            } label: {
                HStack {
                    Text(isRegisterAccount ? "REGISTER" : "LOGIN")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.vertical, 20)
            }
            .overlay {
                if authViewModel.isLoading {
                    HStack {
                        ProgressView()
                            .tint(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.vertical, 20)
                }
            }
            
            
            HStack {
                Text(isRegisterAccount ? "Already have an account" : "Don't have an account")
                
                Spacer()
                
                Button(isRegisterAccount ? "Login" : "Register") {
                    withAnimation(.spring()) {
                        isRegisterAccount.toggle()
                    }
                }
            }
            
        }
        .padding()
        .background(Color("BGColor"))
        .alert(isPresented: $authViewModel.showAlert) {
            Alert(title: Text(authViewModel.alertTitle), message: Text(authViewModel.alertMessage), dismissButton: .cancel())
        }
        
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static let authViewModel = AuthViewModel()
    
    static var previews: some View {
        AuthenticationView()
            .environmentObject(authViewModel)
    }
}
