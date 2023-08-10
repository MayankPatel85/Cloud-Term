//
//  ProfileView.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-13.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Circle()
                    .frame(width: 120, height: 120)
                    .overlay {
                        Text(authViewModel.getCurrentUserEmail().prefix(1))
                            .font(.system(size: 54))
                            .foregroundColor(.white)
                    }
                
                Text(authViewModel.getCurrentUserEmail())
                    .font(.title3)
                
//                Spacer()
                
                NavigationLink {
                    SizeView()
                } label: {
                    VStack(spacing: 25) {
                        HStack {
                            Text("Choose your size")
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                        .font(.title3)
                        .foregroundColor(.black)
                        
                        Divider()
                            .background(Color.black)
                    }
                    .padding()
                }
                
                Spacer()
                
                Button {
                    authViewModel.logout()
                } label: {
                    HStack {
                        Text("LOGOUT")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.vertical, 20)
                    .padding(.horizontal)
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
                        .padding(.horizontal)
                    }
                }

            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static let authViewModel = AuthViewModel()
    
    static var previews: some View {
        ProfileView()
            .environmentObject(authViewModel)
    }
}
