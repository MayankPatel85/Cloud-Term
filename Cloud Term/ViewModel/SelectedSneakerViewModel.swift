//
//  SelectedSneakerViewModel.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-13.
//

import Foundation

class SelectedSneakerViewModel: ObservableObject {
    @Published var selectedSneaker: Sneaker = sneakers[0]
    @Published var showDetail: Bool = false
}
