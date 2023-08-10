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
    
    func fetchSneakers() async {
        await MainActor.run {
            self.isLoading = true
        }
        do {
            let response = try await NetworkManager.getData(url: "\(Constants.apiUrl)/sneakers")
            let data = try JSONDecoder().decode([Sneaker].self, from: response)
            await MainActor.run {
                self.sneakers = data
                self.isLoading = false
            }
        } catch {
            print("Error fetching sneakers \(error)")
        }
    }
    
    func postEntry(sneaker: Sneaker, size: String) async {
        guard let user = Auth.auth().currentUser, let userEmail = user.email else { return }
        await MainActor.run {
            self.isLoading = true
        }
        do {
            let entry = Entry(userId: user.uid, email: userEmail, releaseDate: sneaker.releaseDate, size: size, sneakerId: sneaker.id, sneakerName: sneaker.name, imageUrl: sneaker.images[0])
            _ = try await NetworkManager.postData(url: "\(Constants.apiUrl)/submitEntry", data: entry)
            await MainActor.run {
                self.isLoading = false
            }
        } catch {
            print("Error submitting entry \(error)")
        }
    }
    
    func getResults() async {
        guard let user = Auth.auth().currentUser else { return }
        await MainActor.run {
            self.isLoading = true
        }
        do {
            let response = try await NetworkManager.getData(url: "\(Constants.apiUrl)/getResult/\(user.uid)")
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
