//
//  Result.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-30.

import Foundation

// MARK: - Result
struct Results: Codable, Identifiable {
    var id = UUID()
    let email: String
    let imageUrl: String
    let releaseDate: String
    let size: String
    let sneakerId: String
    let sneakerName: String
    let status: String
}

struct Result: Codable {
    let userId: String
    let results: [Results]
}
