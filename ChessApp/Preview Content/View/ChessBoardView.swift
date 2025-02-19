//
//  ChessBoardView.swift
//  ChessApp
//
//  Created by Oscar on 2025-02-18.
//

import Foundation
import SwiftUI

struct ChessBoardView: View {
    @Bindable var viewModel: ChessGameViewModel
    
    @State private var selectedPiecePosition: (Int, Int)? = nil

    var body: some View {
        GeometryReader { geometry in
            let squareSize = min(geometry.size.width, geometry.size.height) / 8

            VStack(spacing: 0) {
                ForEach((0..<8).reversed(), id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<8, id: \.self) { col in
                            let position = (row, col)
                            let piece = viewModel.getPiece(at: position)
                            
                            ZStack {
                          
                                Rectangle()
                                    .fill((row + col) % 2 == 0 ? Color.white : Color.gray)
                                    .frame(width: squareSize, height: squareSize)
                                    .border(isSelected(position) ? Color.blue : Color.clear, width: 3) // show selected
                                    .onTapGesture {
                                        handleTap(at: position, piece: piece)
                                    }

                                // Display the piece
                                if let piece = piece {
                                    Text(ChessConstants.pieceSymbols[piece.type] ?? "?")
                                        .font(.system(size: squareSize * 0.7))
                                        .foregroundColor(piece.color == .white ? .white : .black)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func isSelected(_ position: (Int, Int)) -> Bool {
    
        if let selectedPosition = selectedPiecePosition {
            return selectedPosition == position
        }
        return false
    }

    
    // tap to move
    private func handleTap(at position: (Int, Int), piece: ChessPiece?) {
        if let selectedPiece = selectedPiecePosition {
          
            viewModel.movePiece(from: selectedPiece, to: position)
            selectedPiecePosition = nil
        } else {
         
            if piece != nil {
                selectedPiecePosition = position
            }
        }
    }
}
