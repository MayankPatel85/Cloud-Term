//
//  SneakerViewModelTests.swift
//  Cloud TermTests
//
//  Created by Mayank Patel on 2023-08-18.
//

import XCTest
@testable import Cloud_Term

final class SneakerViewModelTests: XCTestCase {
    private var sneakerViewModel: SneakerViewModel!
    private var session: URLSession!
    private var mockNetworkManager: NetworkManagerImpl!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockUrlSessionProtocol.self]
        session = URLSession(configuration: configuration)
        
        MockNetworkManager.session = session
        mockNetworkManager = MockNetworkManager()
        
        sneakerViewModel = SneakerViewModel(networkManager: mockNetworkManager)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sneakerViewModel = nil
        session = nil
        mockNetworkManager = nil
    }
    
    func testSuccessfullFetchSneakers() async throws {
        MockNetworkManager.completionHandler = {
            let mockSneakerData = try! JSONEncoder().encode(sneakers)
            return mockSneakerData
        }
        
        await sneakerViewModel.fetchSneakers()
        
        XCTAssertEqual(sneakerViewModel.sneakers.count, 1)
    }
    
    func testUnsuccessfullFetchSneakers() async throws {
        MockNetworkManager.completionHandler = {
            throw NMError.invalidResponse
        }
        
        await sneakerViewModel.fetchSneakers()
        
        XCTAssertEqual(sneakerViewModel.sneakers.count, 0)
    }
    
    func testSuccessfullPostEntry() async throws {
        MockNetworkManager.completionHandler = {
            let mockEntryconfirmation = try! JSONEncoder().encode("Successfully submited entry")
            return mockEntryconfirmation
        }
        
        do {
            try await sneakerViewModel.postEntry(sneaker: sneakers[0], size: "8.0")
        } catch {
            XCTAssertNil(error)
        }
    }
    
    func testUnsuccessfullPostEntryWithNullUser() async throws {
        MockNetworkManager.completionHandler = {
            throw UserError.NullUser
        }
        
        do {
            try await sneakerViewModel.postEntry(sneaker: sneakers[0], size: "8.0")
        } catch {
            XCTAssertEqual(error as! UserError, UserError.NullUser)
        }
    }
    
    func testSuccessfullGetResults() async throws {
        MockNetworkManager.completionHandler = {
            let mockResults = Result(userId: "mockId", results: [Results(email: "test@test.com", imageUrl: "imageUrl", releaseDate: "08-19-2023", size: "8.0", sneakerId: "aj1", sneakerName: "Air Jordan 1 UNC", status: "W")])
            return try! JSONEncoder().encode(mockResults)
        }
        
        try await sneakerViewModel.getResults()
        
        XCTAssertEqual(sneakerViewModel.result?.results.count, 1)
        XCTAssertEqual(sneakerViewModel.result?.userId, "mockId")
    }
    
    func testUnuccessfullGetResultsWithNullUser() async throws {
        MockNetworkManager.completionHandler = {
            throw UserError.NullUser
        }
        
        do {
            try await sneakerViewModel.getResults()
        } catch {
            XCTAssertNotNil(error)
            XCTAssertEqual(error as! UserError, UserError.NullUser)
        }
    }
    
    func testSuccessfullGetResultsWithEmptyResults() async throws {
        MockNetworkManager.completionHandler = {
            let mockResults = Result(userId: "mockId", results: [])
            return try! JSONEncoder().encode(mockResults)
        }
        
        try await sneakerViewModel.getResults()
        
        XCTAssertEqual(sneakerViewModel.result?.results.count, 0)
        XCTAssertEqual(sneakerViewModel.result?.userId, "mockId")
        XCTAssertTrue(sneakerViewModel.result!.results.isEmpty)
    }

}
