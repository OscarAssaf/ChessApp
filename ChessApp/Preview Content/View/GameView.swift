//
//  GameView.swift
//  ChessApp
//
//  Created by Oscar on 2025-02-18.
//

import Foundation

import SwiftUI

struct GameView: View {
    @State private var viewModel = ChessGameViewModel()

    var body: some View {
        VStack {
            Text("Turn: \(viewModel.currentTurn == .white ? "White" : "Black")")
                .font(.headline)
            
            ChessBoardView(viewModel: viewModel)
        }
    }
}
