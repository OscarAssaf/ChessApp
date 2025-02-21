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
        VStack {
            Text("Chess Openings")
                .font(.largeTitle)
                .padding()
            
            
            List {
                Text("Ruy-Lopez")
                Text("Sicilian Defense")
                Text("French Defense")
                Text("Caro-Kann Defense")
            }
        }
    }
}

#Preview {
    OpeningsView()
}
