//
//  FavouritesView.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-13.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var sneakerViewModel: SneakerViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let result = sneakerViewModel.result {
                        ForEach(result.results) { result in
                            LazyHStack {
                                AsyncImage(url: URL(string: result.imageUrl)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                        .frame(width: 100, height: 100)
                                        .padding(.leading)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                }
                                
                                Text(result.sneakerName)
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                if result.status == "W" {
                                    VStack {
                                        Text("GOT'")
                                            .fontWeight(.bold)
                                        
                                        Text("EM")
                                            .fontWeight(.bold)
                                    }
                                    .frame(width: 74)
                                    .padding()
                                } else {
                                    VStack {
                                        Text("LOST'")
                                            .fontWeight(.bold)
                                        
                                        Text("EM")
                                            .fontWeight(.bold)
                                    }
                                    .frame(width: 74)
                                    .padding()
                                }
                            }
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .background(RoundedRectangle(cornerRadius: 24)
                                .stroke(style: .init())
                            )
                        .padding()
                        }
                    }
                }
                .navigationTitle("Results")
            }
            .onAppear {
                Task {
                    try await sneakerViewModel.getResults()
                }
            }
            .overlay {
                if sneakerViewModel.isLoading {
                    ProgressView()
                }
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static let sneakerViewModel = SneakerViewModel()
    
    static var previews: some View {
        ResultsView()
            .environmentObject(sneakerViewModel)
    }
}
