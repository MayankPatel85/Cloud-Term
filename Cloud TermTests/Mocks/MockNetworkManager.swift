//
//  MockNetworkManager.swift
//  Cloud TermTests
//
//  Created by Mayank Patel on 2023-08-18.
//

import Foundation
import XCTest
@testable import Cloud_Term

class MockNetworkManager: XCTest, NetworkManagerImpl {
    static var completionHandler: (() throws -> Data)?
    static var session: URLSession!
    
    func getData(url: String, session: URLSession = session) async throws -> Data {
        guard let handler = MockNetworkManager.completionHandler else {
            XCTFail("completion handler is required")
            return Data()
        }
        return try handler()
    }
    
    func postData<T>(url: String, data: T, session: URLSession = session) async throws -> Data where T : Encodable {
        guard let handler = MockNetworkManager.completionHandler else {
            XCTFail("completion handler is required")
            return Data()
        }
        return try handler()
    }
    
}
