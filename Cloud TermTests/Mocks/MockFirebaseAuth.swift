//
//  MockFirebaseAuth.swift
//  Cloud TermTests
//
//  Created by Mayank Patel on 2023-08-18.
//

import Foundation
import FirebaseAuth
import XCTest
@testable import Cloud_Term

class MockFirebaseAuth: AuthImpl {
    static var error: Error?
    
    func createUser(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        if MockFirebaseAuth.error != nil {
            completion?(nil, MockFirebaseAuth.error)
        } else {
            completion?(nil, nil)
        }
    }
    
    func signIn(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        if MockFirebaseAuth.error != nil {
            completion?(nil, MockFirebaseAuth.error)
        } else {
            completion?(nil, nil)
        }
    }
    
    func signOut() throws {
        if let error = MockFirebaseAuth.error {
            throw error
        } else {
            return
        }
    }
    
    
}
