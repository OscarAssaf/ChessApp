//
//  ChessGameViewModel.swift
//  ChessApp
//
//  Created by Oscar on 2025-02-18.
//

import Foundation

import SwiftUI

@Observable
class ChessGameViewModel {
    var board = ChessBoard()
    var currentTurn: PieceColor = .white
    
    func movePiece(from: (Int, Int), to: (Int, Int)) {
        guard let piece = board.board[from.0][from.1], piece.color == currentTurn else { return }
        
        if board.movePiece(from: from, to: to) {
            currentTurn = (currentTurn == .white) ? .black : .white
        }
    }
    
    func getPiece(at position: (Int, Int)) -> ChessPiece? {
        return board.board[position.0][position.1]
    }
}
