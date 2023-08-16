//
//  Home.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-12.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var selectedSneakerViewModel: SelectedSneakerViewModel
    @EnvironmentObject var sneakerViewModel: SneakerViewModel
    var namespace: Namespace.ID
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Feed")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.top, 73)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(sneakerViewModel.sneakers) { sneaker in
                    SneakerCard(sneaker: sneaker, namespace: namespace)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
                                selectedSneakerViewModel.showDetail.toggle()
                                selectedSneakerViewModel.selectedSneaker = sneaker
                            }
                        }
                }
            }
            .padding(.bottom , 68)
        }
        .task {
            await sneakerViewModel.fetchSneakers()
        }
        .overlay {
            if(sneakerViewModel.isLoading) {
                ProgressView()
            }
        }
        .ignoresSafeArea()
        .background(Color(uiColor: .systemGray6))
    }
    
}

struct Home_Previews: PreviewProvider {
    static let sneakerViewModel = SneakerViewModel()
    @Namespace static var namespace

    static var previews: some View {
        HomeView(selectedSneakerViewModel: SelectedSneakerViewModel(), namespace: self.namespace)
            .environmentObject(sneakerViewModel)
    }
}
