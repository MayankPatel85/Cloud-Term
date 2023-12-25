//
//  AuthViewModel.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-15.
//

import Foundation
import FirebaseAuth

protocol AuthImpl {
//    var currentUser: User? { get }
    func createUser(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
    func signIn(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?)
    func signOut() throws
}

extension Auth: AuthImpl { }

class AuthViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var alertTitle: String = ""
    @Published var showAuthScreen: Bool = false
    
    private var networkManager: NetworkManagerImpl
    private var auth: AuthImpl
    
    init(auth: AuthImpl = Auth.auth(), networkManager: NetworkManagerImpl = NetworkManager.shared) {
        self.auth = auth
        self.networkManager = networkManager
        Auth.auth().addStateDidChangeListener { _, user in
            if user == nil {
                self.showAuthScreen = true
            } else {
                self.showAuthScreen = false
            }
        }
    }
    
    /// registers a user in firebase authentication
    /// - Parameters:
    ///   - email: email of the user
    ///   - password: password of the user
    func register(email: String, password: String) {
        self.isLoading = true
        auth.createUser(withEmail: email, password: password) { [self] (result, error) in
            if error != nil {
                alertTitle = "Something Went Wrong!"
                alertMessage = error!.localizedDescription
                isLoading = false
                showAlert.toggle()
            }
            else {
                alertTitle = "WooHoo"
                alertMessage = "Successful"
                isLoading = false
                showAlert.toggle()
            }
        }
    }
    
    /// performs firebase sign in using email and password
    /// - Parameters:
    ///   - email: email of the user
    ///   - password: password of the user
    func signIn(email: String, password: String) {
        isLoading = true
        auth.signIn(withEmail: email, password: password) { [self] (result, error) in
            if error != nil {
                alertTitle = "Something Went Wrong!"
                alertMessage = error!.localizedDescription
                isLoading = false
                showAlert.toggle()
            }
            isLoading = false
        }
    }
    
    /// subscribes user to AWS SNS topic via POST API request
    /// - Parameter email: email address of the user
    func subscribeEmail(email: String) async {
        await MainActor.run {
            self.isLoading = true
        }
        do {
            let _ = try await networkManager.postData(url: "\(Constants.apiUrl)/subscribeForEmail", data: SubscribeEmail(email: email), session: .shared)
            await MainActor.run {
                self.isLoading = false
            }
        } catch {
            print("Error submitting entry \(error)")
        }
    }
    
    /// retrieves the logged in user's email address
    /// - Returns: email of the user
    func getCurrentUserEmail() -> String {
        if let userEmail = Auth.auth().currentUser?.email {
            return userEmail
        } else {
            return "Email"
        }
    }
    
    /// log out the current user
    func logout() {
        do {
            try auth.signOut()
        } catch {
            print("Error in logout \(error)")
        }
    }
    
}
