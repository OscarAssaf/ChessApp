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
        guard let piece = board.board[from.0][from.1] else {
            print("No piece at selected position")
            return
        }
        
        print("Selected piece: \(piece.type.rawValue) (\(piece.color == .white ? "White" : "Black"))")
        print("Current turn: \(currentTurn == .white ? "White" : "Black")")
        
        if piece.color != currentTurn {
            print("Wrong turn! It's \(currentTurn == .white ? "White" : "Black")'s turn.")
            return
        }

        if board.movePiece(from: from, to: to) {
            currentTurn = (currentTurn == .white) ? .black : .white
            print("Turn changed to \(currentTurn == .white ? "White" : "Black")")
        }
    }

    
    func getPiece(at position: (Int, Int)) -> ChessPiece? {
        return board.board[position.0][position.1]
    }
}

