//
//  NetworkManager.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-17.
//

import Foundation

protocol NetworkManagerImpl {
    func getData(url: String, session: URLSession) async throws -> Data
    func postData<T: Encodable>(url: String, data: T, session: URLSession) async throws -> Data
}

class NetworkManager: NetworkManagerImpl {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func getData(url: String, session: URLSession) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NMError.invalidUrl
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NMError.invalidResponse
        }
        
        return data
    }
    
    func postData<T: Encodable>(url: String, data: T, session: URLSession) async throws -> Data {
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
        
        let (data, response) = try await session.upload(for: request, from: dataToJson)
        
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
