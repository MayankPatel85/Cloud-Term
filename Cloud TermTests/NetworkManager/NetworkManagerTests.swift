//
//  NetworkManagerTests.swift
//  Cloud TermTests
//
//  Created by Mayank Patel on 2023-08-17.
//

import XCTest
@testable import Cloud_Term

final class NetworkManagerTests: XCTestCase {
    
    private var session: URLSession?
    private var url = "https://d5wnn62goi.execute-api.us-east-1.amazonaws.com/prod"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockUrlSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        url = ""
    }
    
    func testWithSuccessfullResponse() async throws {
        let data = Data()
        
        MockUrlSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: URL(string: self.url)!, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, data)
        }
        
        _ = try await NetworkManager.shared.getData(url: self.url, session: session!)
    }

}
