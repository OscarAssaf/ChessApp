//
//  OpeningsView.swift
//  ChessApp
//
//  Created by Oscar Assaf on 2025-02-21.
//

import Foundation

import SwiftUI

struct OpeningsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Chess Openings")
                    .font(.largeTitle)
                    .padding()
                
                List {
                    NavigationLink(destination: SicilianDefenseView()) {
                        Text("Sicilian Defense")
                    }
                        NavigationLink(destination: QueensGambitView()) {
                            Text("Queen's gambit")
                        }
                    }
                }
                .navigationTitle("Openings")
            }
        }
    }

