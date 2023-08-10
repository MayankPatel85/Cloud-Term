//
//  SizeView.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-16.
//

import SwiftUI

struct SizeView: View {
    @AppStorage("userSize") private var userSize = ""
//    @State private var userSize = 7.0
    
    let sizes = ["7.0", "7.5", "8.0", "8.5", "9.0", "9.5", "10.0", "10.5", "11.0", "11.5", "12.0", "13.0"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 30) {
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(sizes, id: \.self) { size in
                        Button {
                            withAnimation(.spring()) {
                                userSize = size
                            }
                        } label: {
                            if size == userSize {
                                RoundedRectangle(cornerRadius: 14)
                                    .overlay {
                                        Text(size)
                                            .foregroundColor(.white)
                                    }
                                    .foregroundColor(.black)
                                    .frame(width: 100, height: 80)
                            } else {
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(style: .init())
                                    .overlay {
                                        Text(size)
                                    }
                                    .foregroundColor(.black)
                                    .frame(width: 100, height: 80)
                            }
                        }

                    }
                }
                .padding(.top, 50)
                
                Spacer()
                
            }
            .navigationTitle("US Sizes")
        }
    }
}

struct SizeView_Previews: PreviewProvider {
    static var previews: some View {
        SizeView()
    }
}
