//
//  DetailView.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-12.
//

import SwiftUI

struct DetailView: View {
    //    @Binding var showDetail: Bool
    @AppStorage("userSize") private var userSize: String?
    @EnvironmentObject var sneakerViewModel: SneakerViewModel
    @ObservedObject var selectedSneakerViewModel: SelectedSneakerViewModel
    @State private var showElements: Bool = false
    @State private var showAlert: Bool = false
    @State private var joined: Bool = false
    var namespace: Namespace.ID
    
    var body: some View {
        VStack {
            ScrollView {
                
                VStack {
                    CacheAsyncImage(url: URL(string: selectedSneakerViewModel.selectedSneaker.images[0])!) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .matchedGeometryEffect(id: selectedSneakerViewModel.selectedSneaker.id + "Image", in: namespace)
                                .frame(height: 370)
                                .background(
                                    Color("BGColor")
                                        .matchedGeometryEffect(id: selectedSneakerViewModel.selectedSneaker.id + "IamgeBackground", in: namespace)
                                )
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(selectedSneakerViewModel.selectedSneaker.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .matchedGeometryEffect(id: selectedSneakerViewModel.selectedSneaker.id + selectedSneakerViewModel.selectedSneaker.name, in: namespace)
                        
                        Text("M 7-M 13")
                            .padding(.top, 4)
                            .opacity(showElements ? 1 : 0)
                        
                        Text("\(selectedSneakerViewModel.selectedSneaker.releaseDate) 07 AM")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .matchedGeometryEffect(id: selectedSneakerViewModel.selectedSneaker.id + "Launch Time", in: namespace)
                        
                        Text(selectedSneakerViewModel.selectedSneaker.description)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .lineSpacing(7)
                            .padding(.vertical, 3)
                            .opacity(showElements ? 1 : 0)
                    }
                    .padding(.horizontal)
                    
                    ForEach(selectedSneakerViewModel.selectedSneaker.images, id: \.self) { image in
                        AsyncImage(url: URL(string: image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 370)
                                .background(Color("BGColor"))
                                .padding(.vertical)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .frame(height: 370)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .overlay(alignment: .bottom) {
            if selectedSneakerViewModel.selectedSneaker.allowEntry {
                Button {
                    Task {
                        if let size = userSize, size != "" {
                            try await sneakerViewModel.postEntry(sneaker: selectedSneakerViewModel.selectedSneaker, size: size)
                            joined.toggle()
                        } else {
                            showAlert.toggle()
                        }
                    }
                } label: {
                    DrawButton(text: "Join Draw", textColor: .white)
                        .opacity(showElements ? 1 : 0)
                        .overlay {
                            if sneakerViewModel.isLoading {
                                HStack(alignment: .center) {
                                    ProgressView()
                                        .tint(.white)
                                }
                                //                            .padding()
                                .frame(maxWidth: .infinity)
                                .background(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 24))
                                .padding()
                                .padding(.bottom)
                            }
                        }
                }
            } else {
                DrawButton(text: "Draw Closed", opacity: showElements ? 1 : 0)
            }
            if joined {
                DrawButton(text: "Draw Joined", opacity: showElements ? 1 : 0)
            }
        }
        .overlay(alignment: .topTrailing) {
            Image(systemName: "xmark")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
                .padding(24)
                .opacity(showElements ? 1 : 0)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedSneakerViewModel.showDetail.toggle()
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.white))
                .matchedGeometryEffect(id: selectedSneakerViewModel.selectedSneaker.id + "Background", in: namespace)
        )
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.35)) {
                showElements.toggle()
            }
        }
        .ignoresSafeArea()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("No Size Selected!"), message: Text("Please select your size from profile screen."), dismissButton: .cancel())
        }
        .statusBarHidden(true)
        //        .background(.white)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let sneakerViewModel = SneakerViewModel()
    @Namespace static var namespace
    
    static var previews: some View {
        DetailView(selectedSneakerViewModel: SelectedSneakerViewModel(), namespace: self.namespace)
            .environmentObject(sneakerViewModel)
    }
}
