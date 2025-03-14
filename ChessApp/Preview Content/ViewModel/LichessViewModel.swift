//
//  LichessViewModel.swift
//  ChessApp
//
//  Created by Oscar Assaf on 2025-03-03.
//

import Foundation
import Observation


@Observable
class LichessViewModel {
    var lichessUser: LichessUser?
    private(set) var isLoading = false
    private(set) var errorMessage: String?
    
    func fetchUser(username: String) async {
        let urlString = "https://lichess.org/api/user/\(username)"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let user = try decoder.decode(LichessUser.self, from: data)
            self.lichessUser = user
            errorMessage = nil
        } catch {
            print("Error fetching user:", error)
            errorMessage = "Failed to load user data"
        }
        
        isLoading = false
    }
}
