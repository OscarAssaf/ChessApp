//
//  ChessBoardView.swift
//  ChessApp
//
//  Created by Oscar on 2025-02-18.
//

import SwiftUI

struct ChessBoardView: View {
    @State var viewModel: ChessGameViewModel

    var body: some View {
        GeometryReader { geometry in
            let squareSize = min(geometry.size.width, geometry.size.height) / 8

            VStack(spacing: 0) {
                ForEach(Array((0..<8).reversed()), id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(Array((0..<8).reversed()), id: \.self) { col in
                            let position = (row, col)
                            let piece = viewModel.getPiece(at: position)
                            let isSelected = viewModel.selectedPiecePosition == position

                            ZStack {
                                Rectangle()
                                    .fill((row + col) % 2 == 0 ? Color.white : Color.gray)
                                    .frame(width: squareSize, height: squareSize)
                                    .border(isSelected ? Color.blue : Color.clear, width: 3)
                                    .onTapGesture {
                                        viewModel.selectOrMovePiece(at: position)
                                    }

                                if let piece = piece {
                                    Text(ChessConstants.pieceSymbols[piece.type] ?? "?")
                                        .font(.system(size: 40))
                                        .foregroundColor(piece.color == .white ? .black : .white)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
