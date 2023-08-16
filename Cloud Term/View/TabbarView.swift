//
//  TabView.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-13.
//

import SwiftUI
import FirebaseAuth

struct TabbarView: View {
    @StateObject var sneakerViewModel = SneakerViewModel()
    @StateObject var selectedSneakerViewModel = SelectedSneakerViewModel()
    @StateObject var authViewModel = AuthViewModel()
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            TabView {
                NavigationView {
                    HomeView(selectedSneakerViewModel: selectedSneakerViewModel, namespace: namespace)
                        .environmentObject(sneakerViewModel)
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                NavigationView {
                    ResultsView()
                        .environmentObject(sneakerViewModel)
                }
                .tabItem {
                    Image(systemName: "chart.bar.doc.horizontal")
                    Text("Results")
                }
                
                NavigationView {
                    ProfileView()
                        .environmentObject(authViewModel)
                }
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            }
            .tint(.black)
            .zIndex(1)
            
            if selectedSneakerViewModel.showDetail {
                DetailView(selectedSneakerViewModel: selectedSneakerViewModel, namespace: namespace)
                    .zIndex(2)
                    .environmentObject(sneakerViewModel)
            }
        }
        .fullScreenCover(isPresented: $authViewModel.showAuthScreen) {
            AuthenticationView()
                .environmentObject(authViewModel)
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static let authViewModel = AuthViewModel()
    
    static var previews: some View {
        TabbarView(authViewModel: authViewModel)
    }
}
