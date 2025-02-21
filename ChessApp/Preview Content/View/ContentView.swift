//
//  ContentView.swift
//  ChessApp
//
//  Created by Oscar Assaf on 2025-02-21.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                GameView()
                    .navigationTitle("Chess Game")
            }
            .tabItem {
                Label("Game", systemImage: "gamecontroller.fill")
            }

            NavigationStack {
                OpeningsView()
                    .navigationTitle("Openings")
            }
            .tabItem {
                Label("Openings", systemImage: "book")
            }

            NavigationStack {
                ProfileView()
                    .navigationTitle("Profile")
            }
            .tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
        }
    }
}

#Preview {
    ContentView()
}

