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

    //move validator
    func canMove(to newPosition: (Int, Int), board: ChessBoard) -> Bool {
        switch type {
        case .pawn:
            return isValidPawnMove(to: newPosition, board: board)
        default:
            return false // REMEMBER TO ADD OTHER PIECES HERE LATER!!!!!!!!!!
        }
    }

    // Pawn logic
    private func isValidPawnMove(to newPosition: (Int, Int), board: ChessBoard) -> Bool {
        let (startRow, startCol) = position
        let (endRow, endCol) = newPosition
        let direction = (color == .white) ? -1 : 1 // move direction

        // one step forward
        if startCol == endCol && endRow == startRow + direction && board.isEmpty(at: newPosition) {
            return true
        }

        // 2 moves
        if startCol == endCol && startRow == (color == .white ? 6 : 1) && endRow == startRow + 2 * direction {
            return board.isEmpty(at: newPosition) && board.isEmpty(at: (startRow + direction, startCol))
        }

        // Capturing
        if abs(startCol - endCol) == 1 && endRow == startRow + direction {
            return board.hasOpponentPiece(at: newPosition, for: color)
        }

        return false
    }
}
