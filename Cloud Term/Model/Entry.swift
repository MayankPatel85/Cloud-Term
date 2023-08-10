//
//  Entry.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-29.
//

import Foundation

struct Entry: Codable {
    var id = UUID().uuidString
    let userId: String
    let email: String
    let releaseDate: String
    let size: String
    let sneakerId: String
    let sneakerName: String
    let imageUrl: String
}
