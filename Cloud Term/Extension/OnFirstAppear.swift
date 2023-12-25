//
//  OnFirstAppear.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-12-25.
//

import Foundation
import SwiftUI

private struct OnFirstAppear: ViewModifier {
    let action: () -> Void
    @State private var loaded: Bool = false
    
    func body(content: Content) -> some View {
        content.onAppear {
            if !loaded {
                loaded = true
                action()
            }
        }
    }
}

extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(OnFirstAppear(action: action))
    }
}
