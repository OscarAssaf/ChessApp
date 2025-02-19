//
//  ChessBoard.swift
//  ChessApp
//
//  Created by Oscar on 2025-02-18.
//

import Foundation

struct ChessBoard {
    var board: [[ChessPiece?]] = Array(repeating: Array(repeating: nil, count: 8), count: 8)
    
    init() {
        setupBoard()
    }
    
    private mutating func setupBoard() {
       
        board = Array(repeating: Array(repeating: nil, count: 8), count: 8)

        
        for col in 0..<8 {
            board[1][col] = ChessPiece(type: .pawn, color: .black, position: (1, col))
            board[6][col] = ChessPiece(type: .pawn, color: .white, position: (6, col))
        }
        
       
        placeMajorPieces(row: 0, color: .black)
        placeMajorPieces(row: 7, color: .white)
    }

    private mutating func placeMajorPieces(row: Int, color: PieceColor) {
        let pieceOrder: [PieceType] = [.rook, .knight, .bishop, .queen, .king, .bishop, .knight, .rook]
        for col in 0..<8 {
            board[row][col] = ChessPiece(type: pieceOrder[col], color: color, position: (row, col))
        }
    }
    
    mutating func movePiece(from start: (row: Int, col: Int), to end: (row: Int, col: Int)) {
            board[end.row][end.col] = board[start.row][start.col]
            board[start.row][start.col] = nil
        }
    		
    func getPiece(at position: (row: Int, col: Int)) -> ChessPiece? {
            return board[position.row][position.col]
        }
}

