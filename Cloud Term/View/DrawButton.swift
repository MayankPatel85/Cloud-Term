//
//  DrawButton.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-08-07.
//

import SwiftUI

struct DrawButton: View {
    let text: String
    let textColor: Color
    let opacity: Double
    let backgroundColor: Color
    
    init(text: String = "Draw",
         textColor: Color = .black.opacity(0.8),
         opacity: Double = 1,
         backgroundColor: Color = .init(uiColor: .systemGray4)
    )
    {
        self.text = text
        self.textColor = textColor
        self.opacity = opacity
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        VStack {
            Text(text.capitalized)
                .fontWeight(.medium)
                .foregroundColor(textColor)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding()
        .padding(.bottom)
        .opacity(opacity)
    }
}

struct DrawButton_Previews: PreviewProvider {
    static var previews: some View {
        DrawButton()
    }
}
