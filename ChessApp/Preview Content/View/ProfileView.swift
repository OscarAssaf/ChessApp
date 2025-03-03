//
//  ProfileView.swift
//  ChessApp
//
//  Created by Oscar Assaf on 2025-02-21.
//

import SwiftUI

struct ProfileView: View {
    @State private var username: String = "zuets"  // Default username
    @State private var lichessViewModel = LichessViewModel()

    var body: some View {
        VStack {
            TextField("Enter Lichess Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Fetch Profile") {
                Task {
                    await lichessViewModel.fetchUser(username: username)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            if let user = lichessViewModel.lichessUser {
                VStack {
                    Text("Lichess Profile: \(user.username)")
                        .font(.title2)
                        .bold()

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Bullet: \(user.perfs.bullet.rating) (\(user.perfs.bullet.games) games)")
                            Text("Blitz: \(user.perfs.blitz.rating) (\(user.perfs.blitz.games) games)")
                            Text("Rapid: \(user.perfs.rapid.rating) (\(user.perfs.rapid.games) games)")
                            Text("Puzzle: \(user.perfs.puzzle.rating) (\(user.perfs.puzzle.games) games)")
                        }
                        .padding()

                        Spacer()
                    }

                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
            } else if lichessViewModel.isLoading {
                ProgressView()
            } else if let errorMessage = lichessViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ProfileView()
}
