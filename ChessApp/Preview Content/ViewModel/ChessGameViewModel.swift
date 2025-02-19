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
    var board: ChessBoard
    var currentTurn: PieceColor = .white
    var selectedPiecePosition: (row: Int, col: Int)? = nil 

    init() {
        board = ChessBoard()
    }

    func selectOrMovePiece(at position: (row: Int, col: Int)) {
        if let selected = selectedPiecePosition {
            if movePiece(from: selected, to: position) {
                selectedPiecePosition = nil
                currentTurn = currentTurn == .white ? .black : .white
            }
        } else {
            if let piece = board.getPiece(at: position), piece.color == currentTurn {
                selectedPiecePosition = position
            }
        }
    }

    func movePiece(from start: (row: Int, col: Int), to end: (row: Int, col: Int)) -> Bool {
        guard let piece = board.getPiece(at: start) else { return false }

        if isValidMove(piece: piece, from: start, to: end) {
            board.movePiece(from: start, to: end)
            return true
        }
        return false
    }

    func isValidMove(piece: ChessPiece, from start: (row: Int, col: Int), to end: (row: Int, col: Int)) -> Bool {
        if let destinationPiece = board.getPiece(at: end), destinationPiece.color == piece.color {
            return false
        }
        return true
    }
}
