//
//  NetworkManager.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-17.
//

import Foundation

class NetworkManager {
    
    public static func getData(url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NMError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NMError.invalidResponse
        }
        
        return data
    }
    
    public static func postData<T: Encodable>(url: String, data: T) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NMError.invalidUrl
        }
        
        guard let dataToJson = try? JSONEncoder().encode(data) else {
            print("Error in encoding json")
            throw NMError.invalidData
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = dataToJson
        
        let (data, response) = try await URLSession.shared.upload(for: request, from: dataToJson)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NMError.invalidResponse
        }
        
        return data
        
        
    }
}

enum NMError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}
