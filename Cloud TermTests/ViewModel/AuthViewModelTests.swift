//
//  AuthViewModelTests.swift
//  Cloud TermTests
//
//  Created by Mayank Patel on 2023-08-21.
//

import XCTest
import FirebaseAuth
@testable import Cloud_Term

final class AuthViewModelTests: XCTestCase {
    private var email: String!
    private var password: String!
    private var session: URLSession!
    private var mockNetworkManager: NetworkManagerImpl!
    private var mockFirebaseAuth: AuthImpl!
    private var authViewModel: AuthViewModel!
    
    override func setUpWithError() throws {
        email = "test@test.com"
        password = "mockPassword"
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockUrlSessionProtocol.self]
        session = URLSession(configuration: configuration)
        
        MockNetworkManager.session = session
        mockNetworkManager = MockNetworkManager()
        
        mockFirebaseAuth = MockFirebaseAuth()
        
        authViewModel = AuthViewModel(auth: mockFirebaseAuth, networkManager: mockNetworkManager)
    }
    
    override func tearDownWithError() throws {
        email = nil
        password = nil
        authViewModel = nil
    }

    func testSuccessfullRegister() {
        MockFirebaseAuth.error = nil
        
        authViewModel.register(email: email, password: password)
        
        XCTAssertEqual(authViewModel.alertTitle, "WooHoo")
        XCTAssertEqual(authViewModel.alertMessage, "Successful")
        XCTAssertEqual(authViewModel.isLoading, false)
        XCTAssertEqual(authViewModel.showAlert, true)
    }
    
    func testUnsuccessfullRegister() {
        MockFirebaseAuth.error = MockFirebaseError.invalidRegister
        
        authViewModel.register(email: email, password: password)
        
        XCTAssertEqual(authViewModel.alertTitle, "Something Went Wrong!")
        XCTAssertEqual(authViewModel.alertMessage, MockFirebaseAuth.error?.localizedDescription)
        XCTAssertEqual(authViewModel.isLoading, false)
        XCTAssertEqual(authViewModel.showAlert, true)
    }
    
    func testSuccessfullSignIn() {
        MockFirebaseAuth.error = nil
        
        authViewModel.signIn(email: email, password: password)
        
        XCTAssertEqual(authViewModel.alertTitle, "")
        XCTAssertEqual(authViewModel.alertMessage, "")
        XCTAssertEqual(authViewModel.isLoading, false)
    }
    
    func testUnsuccessfullSignIn() {
        MockFirebaseAuth.error = MockFirebaseError.invalidLogin
        
        authViewModel.signIn(email: email, password: password)
        
        XCTAssertEqual(authViewModel.alertTitle, "Something Went Wrong!")
        XCTAssertEqual(authViewModel.alertMessage, MockFirebaseAuth.error?.localizedDescription)
        XCTAssertEqual(authViewModel.isLoading, false)
        XCTAssertEqual(authViewModel.showAlert, true)
    }
    
    func testSuccessfullSignOut() {
        MockFirebaseAuth.error = nil
        
        XCTAssertNoThrow(authViewModel.logout())
    }

}

enum MockFirebaseError: Error {
    case invalidRegister
    case invalidLogin
    case signoutError
}
