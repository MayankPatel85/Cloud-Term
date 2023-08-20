//
//  ApiEndpointsTests.swift
//  Cloud TermTests
//
//  Created by Mayank Patel on 2023-08-17.
//

import XCTest
@testable import Cloud_Term

final class ApiEndpointsTests: XCTestCase {

    func testSuccessfullApiUrl() {
        let apiUrl = "https://d5wnn62goi.execute-api.us-east-1.amazonaws.com/prod"
        
        XCTAssertEqual(Constants.apiUrl, apiUrl)
    }
    
    func testSuccessfullFetchSneakerApiUrl() {
        let apiUrl = "https://d5wnn62goi.execute-api.us-east-1.amazonaws.com/prod/sneakers"
        
        XCTAssertEqual(Constants.fetchSneakers, apiUrl)
    }
    
    func testSuccessfullPostEntryApiUrl() {
        let apiUrl = "https://d5wnn62goi.execute-api.us-east-1.amazonaws.com/prod/submitEntry"
        
        XCTAssertEqual(Constants.postEntry, apiUrl)
    }
    
    func testSuccessfullGetResultApiUrl() {
        let apiUrl = "https://d5wnn62goi.execute-api.us-east-1.amazonaws.com/prod/getResult/testUserId"
        
        XCTAssertEqual("\(Constants.getResult)/testUserId", apiUrl)
    }

}
