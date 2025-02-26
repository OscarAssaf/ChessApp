//
//  ChessBoard.swift
//  ChessApp
//
//  Created by Oscar on 2025-02-18.
//

import Foundation

struct ChessBoard {
    var board: [[ChessPiece?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)
    var currentTurn: PieceColor = .white // White moves first

    init() {
        setupBoard()
        printBoardSetup()
    }

    private mutating func setupBoard() {
        board = Array(repeating: Array(repeating: nil, count: 8), count: 8)

        // Place pawns
        for col in 0..<8 {
            board[1][col] = ChessPiece(type: .pawn, color: .black, position: (1, col))
            board[6][col] = ChessPiece(type: .pawn, color: .white, position: (6, col))
        }

        // Place other pieces
        placeMajorPieces(row: 0, color: .black)
        placeMajorPieces(row: 7, color: .white)
    }

    private mutating func placeMajorPieces(row: Int, color: PieceColor) {
        let pieceOrder: [PieceType] = [.rook, .knight, .bishop, .queen, .king, .bishop, .knight, .rook]
        for col in 0..<8 {
            board[row][col] = ChessPiece(type: pieceOrder[col], color: color, position: (row, col))
        }
    }

    mutating func movePiece(from: (Int, Int), to: (Int, Int)) -> Bool {
        // Check if there's a piece at the selected position
        guard let piece = board[from.0][from.1] else {
            print("No piece at the selected position. Move failed.")
            return false
        }

        // whos turn is whoms
        if piece.color != currentTurn {
            print("Wrong turn! It's \(currentTurn)'s turn. Move failed.")
            return false
        }

        // move validator
        if piece.canMove(to: to, board: self) {
            print("Move successful: \(piece.type) (\(piece.color)) moved from \(from) to \(to)")

            // Move piece
            board[to.0][to.1] = ChessPiece(type: piece.type, color: piece.color, position: to)
            board[from.0][from.1] = nil

            // Switch turns
            currentTurn = (currentTurn == .white) ? .black : .white
            print("Turn changed to \(currentTurn).")

            return true
        } else {
            print("Invalid move for \(piece.type) at \(from) to \(to). Move failed.")
            return false
        }
    }


    // Helps to check if empty

    func isEmpty(at position: (Int, Int)) -> Bool {
        let (row, col) = position

        // valid ranges
        guard row >= 0, row < 8, col >= 0, col < 8 else {
            print("Error: Attempted to access out-of-bounds position \(position)")
            return false
        }

        return board[row][col] == nil
    }


    // Helps to check if square contains an opp
    func hasOpponentPiece(at position: (Int, Int), for color: PieceColor) -> Bool {
        if let piece = board[position.0][position.1] {
            return piece.color != color
        }
        return false
    }

    private func printBoardSetup() {
        print("Initial Chess Board Setup:")
        for row in (0..<8).reversed() {
            var rowString = ""
            for col in 0..<8 {
                if let piece = board[row][col] {
                    rowString += "\(piece.color == .black ? "B" : "W")\(piece.type.rawValue.prefix(1)) "
                } else {
                    rowString += "-- "
                }
            }
            print(rowString)
        }
    }
}
