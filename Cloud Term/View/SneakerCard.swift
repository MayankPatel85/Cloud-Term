//
//  SneakerCard.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-08-07.
//

import SwiftUI

struct SneakerCard: View {
    let sneaker: Sneaker
    let namespace: Namespace.ID
    
    var body: some View {
        LazyVStack(alignment: .center, spacing: 0) {
            CacheAsyncImage(url: URL(string: sneaker.images[0])!) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: sneaker.id + "Image", in: namespace, isSource: true)
                        .background(
                            Color("BGColor")
                                .matchedGeometryEffect(id: sneaker.id + "IamgeBackground", in: namespace, isSource: true)
                        )
                }
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("\(sneaker.releaseDate) 07 AM")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .matchedGeometryEffect(id: sneaker.id + "Launch Time", in: namespace, isSource: true)
                
                Text(sneaker.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .matchedGeometryEffect(id: sneaker.id + sneaker.name, in: namespace, isSource: true)
                
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 64)
            .background(
                Material.ultraThinMaterial
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .frame(maxWidth: .infinity)
        .frame(height: 330)
        .padding([.bottom, .horizontal])
        //                        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(Color(uiColor: .systemGray6))
                .matchedGeometryEffect(id: sneaker.id + "Background", in: namespace, isSource: true)
        )
        .listRowSeparator(.hidden)
    }
}

struct SneakerCard_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        SneakerCard(sneaker: sneakers[0], namespace: namespace)
    }
}
