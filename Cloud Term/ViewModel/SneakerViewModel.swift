//
//  SneakerViewModel.swift
//  Cloud Term
//
//  Created by Mayank Patel on 2023-07-26.
//

import Foundation
import FirebaseAuth

class SneakerViewModel: ObservableObject {
    @Published var sneakers: [Sneaker] = []
    @Published var isLoading: Bool = false
    @Published var result: Result?
    
    private var networkManager: NetworkManagerImpl
    
    init(networkManager: NetworkManagerImpl = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchSneakers() async {
        await MainActor.run {
            self.isLoading = true
        }
        do {
            let response = try await networkManager.getData(url: Constants.fetchSneakers, session: .shared)
            let data = try JSONDecoder().decode([Sneaker].self, from: response)
            await MainActor.run {
                self.sneakers = data
                self.isLoading = false
            }
        } catch {
            print("Error fetching sneakers \(error)")
        }
    }
    
    func postEntry(sneaker: Sneaker, size: String) async throws {
        guard let user = Auth.auth().currentUser, let userEmail = user.email else {
            throw UserError.NullUser
        }
        await MainActor.run {
            self.isLoading = true
        }
        do {
            let entry = Entry(userId: user.uid, email: userEmail, releaseDate: sneaker.releaseDate, size: size, sneakerId: sneaker.id, sneakerName: sneaker.name, imageUrl: sneaker.images[0])
            _ = try await networkManager.postData(url: "\(Constants.apiUrl)/submitEntry", data: entry, session: .shared)
            await MainActor.run {
                self.isLoading = false
            }
        } catch {
            print("Error submitting entry \(error)")
        }
    }
    
    func getResults() async throws {
        guard let user = Auth.auth().currentUser else {
            throw UserError.NullUser
        }
        await MainActor.run {
            self.isLoading = true
        }
        do {
            let response = try await networkManager.getData(url: "\(Constants.getResult)/\(user.uid)", session: .shared)
            let data = try JSONDecoder().decode(Result.self, from: response)
            await MainActor.run {
                self.result = data
                self.isLoading = false
            }
        } catch {
            print("Error fetching sneakers \(error)")
        }
    }
    
}

enum UserError: Error, Equatable {
    case NullUser
}
