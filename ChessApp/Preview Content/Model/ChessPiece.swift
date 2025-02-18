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
    var position: (Int, Int) // rad, columnen
}
