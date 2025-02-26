//
//  ChessPiece.swift
//  ChessApp
//
//  Created by Oscar on 2025-02-18.
//

import Foundation

enum PieceType: String {
    case pawn, knight, bishop, rook, queen, king
}

enum PieceColor {
    case white, black
}

struct ChessPiece {
    let type: PieceType
    let color: PieceColor
    var position: (Int, Int)

    init(type: PieceType, color: PieceColor, position: (Int, Int)) {
        self.type = type
        self.color = color
        self.position = position
        print("Created piece: \(type.rawValue) - \(color == .white ? "White" : "Black") at \(position)")
    }

    // Move validator
    func canMove(to newPosition: (Int, Int), board: ChessBoard) -> Bool {
        switch type {
        case .pawn:
            return isValidPawnMove(to: newPosition, board: board)
        case .knight:
            return isValidKnightMove(to: newPosition, board: board)
        case .bishop:
            return isValidBishopMove(to: newPosition, board: board)
        default:
            return false // REMEMBER TO ADD OTHER PIECES HERE LATER!!!!!!!!!!
        }
    }

    // Pawn logic
    private func isValidPawnMove(to newPosition: (Int, Int), board: ChessBoard) -> Bool {
        let (startRow, startCol) = position
        let (endRow, endCol) = newPosition
        let direction = (color == .white) ? -1 : 1

        if startCol == endCol && endRow == startRow + direction && board.isEmpty(at: newPosition) {
            return true
        }

        if startCol == endCol && startRow == (color == .white ? 6 : 1) && endRow == startRow + 2 * direction {
            return board.isEmpty(at: newPosition) && board.isEmpty(at: (startRow + direction, startCol))
        }

        if abs(startCol - endCol) == 1 && endRow == startRow + direction {
            return board.hasOpponentPiece(at: newPosition, for: color)
        }

        return false
    }

    // Knight logic
    private func isValidKnightMove(to newPosition: (Int, Int), board: ChessBoard) -> Bool {
        let (startRow, startCol) = position
        let (endRow, endCol) = newPosition

        let validMoves = [
            (startRow + 2, startCol + 1), (startRow + 2, startCol - 1),
            (startRow - 2, startCol + 1), (startRow - 2, startCol - 1),
            (startRow + 1, startCol + 2), (startRow + 1, startCol - 2),
            (startRow - 1, startCol + 2), (startRow - 1, startCol - 2)
        ]

        guard validMoves.contains(where: { $0 == (endRow, endCol) }) else {
            print("Invalid move: Knight can only move in an L-shape.")
            return false
        }

        if let targetPiece = board.board[endRow][endCol] {
            if targetPiece.color == color {
                print("Invalid move: Knight cannot capture own piece.")
                return false
            }
        }
        
        return true
    }

  
    // Bishop logic
    private func isValidBishopMove(to newPosition: (Int, Int), board: ChessBoard) -> Bool {
        let (startRow, startCol) = position
        let (endRow, endCol) = newPosition

        // Check diagonal
        if abs(startRow - endRow) != abs(startCol - endCol) {
            print("Invalid move: Bishop must move diagonally.")
            return false
        }

        // Movement direction
        let rowStep = (endRow > startRow) ? 1 : -1
        let colStep = (endCol > startCol) ? 1 : -1

        var currentRow = startRow + rowStep
        var currentCol = startCol + colStep

        // Check for obstacles
        while currentRow >= 0, currentRow < 8, currentCol >= 0, currentCol < 8 {
            if currentRow == endRow && currentCol == endCol {
                break
            }

            if !board.isEmpty(at: (currentRow, currentCol)) {
                print("Invalid move: Bishop's path is blocked at \(currentRow)  \(currentCol).")
                return false
            }

            currentRow += rowStep
            currentCol += colStep
        }

        // Check if end point is occupied or free
        if let targetPiece = board.board[endRow][endCol], targetPiece.color == color {
            print("Invalid move: Bishop cannot capture own piece.")
            return false
        }

        return true
    }

}
