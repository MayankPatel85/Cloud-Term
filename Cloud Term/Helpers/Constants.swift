//
//  Constants.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-29.
//

import Foundation

struct Constants {
    static let apiUrl = "https://d5wnn62goi.execute-api.us-east-1.amazonaws.com/prod"
    static let fetchSneakers = "\(apiUrl)/sneakers"
    static let postEntry = "\(apiUrl)/submitEntry"
    static let getResult = "\(apiUrl)/getResult"
}
