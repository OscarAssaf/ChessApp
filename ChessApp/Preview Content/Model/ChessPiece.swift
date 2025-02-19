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
}
