//
//  ProfileView.swift
//  ChessApp
//
//  Created by Oscar Assaf on 2025-02-21.
//

import SwiftUI

struct ProfileView: View {
    @State private var username: String = ""
    @State private var lichessViewModel = LichessViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter Lichess Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            if let user = lichessViewModel.lichessUser {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Lichess Profile: \(user.username)")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Game Stats").font(.headline)
                        Divider()
                        Text("Bullet: \(user.perfs.bullet.rating) (\(user.perfs.bullet.games) games)")
                        Text("Blitz: \(user.perfs.blitz.rating) (\(user.perfs.blitz.games) games)")
                        Text("Rapid: \(user.perfs.rapid.rating) (\(user.perfs.rapid.games) games)")
                        Text("Puzzle: \(user.perfs.puzzle.rating) (\(user.perfs.puzzle.games) games)")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Overall Stats").font(.headline)
                        Divider()
                        Text("Total Playtime: \(String(format: "%.2f", secondsToHours(user.playTime.total))) hours")
                        Text("Total Games: \(user.count.all)")
                        Text("Total Wins: \(user.count.win)")
                        Text("Total Losses: \(user.count.loss)")
                        Text("Win/Lose Ratio: \(String(format: "%.2f", winLoseRatio(wins: user.count.win, losses: user.count.loss)))")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
            } else if lichessViewModel.isLoading {
                ProgressView()
            } else if let errorMessage = lichessViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button("Fetch Profile") {
                Task {
                    await lichessViewModel.fetchUser(username: username)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
        }
        .padding()
    }
    
    // Helper function to convert seconds to hours
    private func secondsToHours(_ seconds: Int) -> Double {
        return Double(seconds) / 3600.0
    }
    
    // Helper function to calculate win/lose ratio
    private func winLoseRatio(wins: Int, losses: Int) -> Double {
        guard losses > 0 else { return Double(wins) }
        return Double(wins) / Double(losses)
    }
}

#Preview {
    ProfileView()
}
