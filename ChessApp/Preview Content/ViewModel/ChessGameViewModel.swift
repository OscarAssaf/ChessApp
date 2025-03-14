//
//  ChessGameViewModel.swift
//  ChessApp
//
//  Created by Oscar on 2025-02-18.
//

import Foundation
import SwiftUI
import Observation


@Observable
class ChessGameViewModel {
    var board = ChessBoard()
    var showCheckmateAlert = false
    var checkmateWinner: PieceColor? = nil
    
    func getPiece(at position: (Int, Int)) -> ChessPiece? {
        return board.board[position.0][position.1]
    }
    
    func movePiece(from: (Int, Int), to: (Int, Int)) -> Bool {
        let moveSuccessful = board.movePiece(from: from, to: to)
        
        if moveSuccessful {
            if board.isCheckmate(for: board.currentTurn) {
                print("Checkmate detected in movePiece.")
                checkmateWinner = board.currentTurn == .white ? .black : .white
                showCheckmateAlert = true
            }
        }
        
        return moveSuccessful
    }
    
    func resetGame() {
        board = ChessBoard() // Reset the board
        showCheckmateAlert = false
        checkmateWinner = nil
    }
    
    var currentTurn: PieceColor {
        return board.currentTurn
    }
    
    func isCheckmate(for color: PieceColor) -> Bool {
        return board.isCheckmate(for: color)
    }
}
