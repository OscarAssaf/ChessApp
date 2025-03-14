//
//  ChessBoard.swift
//  ChessApp
//
//  Created by Oscar on 2025-02-18.
//


// sources: https://github.com/jaredcassoutt/chess_swiftui

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
        
        // Place major pieces
        placeMajorPieces(row: 0, color: .black)
        placeMajorPieces(row: 7, color: .white)
    }
    
    private mutating func placeMajorPieces(row: Int, color: PieceColor) {
        let pieceOrder: [PieceType] = [.rook, .knight, .bishop, .king, .queen, .bishop, .knight, .rook]
        for col in 0..<8 {
            board[row][col] = ChessPiece(type: pieceOrder[col], color: color, position: (row, col))
        }
    }
    
    mutating func movePiece(from: (Int, Int), to: (Int, Int)) -> Bool {
        guard let piece = board[from.0][from.1] else {
            print("No piece at the selected position.")
            return false
        }
        
        if piece.color != currentTurn {
            print("Wrong turn! It's \(currentTurn)'s turn.")
            return false
        }
        
        if piece.canMove(to: to, board: self) {
            let capturedPiece = board[to.0][to.1]
            
            // Move piece
            board[to.0][to.1] = ChessPiece(type: piece.type, color: piece.color, position: to)
            board[from.0][from.1] = nil
            
            // Check if move makes the king become checked
            if isKingInCheck(for: currentTurn) {
                print("Move is illegal: Your king would be in check.")
                // Undo move
                board[from.0][from.1] = board[to.0][to.1]
                board[to.0][to.1] = capturedPiece
                return false
            }
            
            // Switch turns
            currentTurn = (currentTurn == .white) ? .black : .white
            
            print("Move successful: \(piece.type) moved from \(from) to \(to)")
            if isKingInCheck(for: currentTurn) {
                print("\(currentTurn) is in check!")
                if isCheckmate(for: currentTurn) {
                    print("Checkmate! \(piece.color) wins!")
                }
            }
            return true
        } else {
            print("Invalid move for \(piece.type).")
            return false
        }
    }
    
    func isEmpty(at position: (Int, Int)) -> Bool {
        return board[position.0][position.1] == nil
    }
    
    func hasOpponentPiece(at position: (Int, Int), for color: PieceColor) -> Bool {
        if let piece = board[position.0][position.1] {
            return piece.color != color
        }
        return false
    }
    
    
    // Used chatgpt for inspirationg as well as the above statement and this github when it came to implementing the whole way of checking for checkmate & check https://chatgpt.com/share/67d42eae-5ccc-8005-8b19-61679ca9f4a7 and https://github.com/jaredcassoutt/chess_swiftui 
    func isKingInCheck(for color: PieceColor) -> Bool {
        let kingPosition = findKing(for: color)
        for row in 0..<8 {
            for col in 0..<8 {
                if let piece = board[row][col], piece.color != color {
                    if piece.canMove(to: kingPosition, board: self) {
                        print("\(color) king is in check.")
                        return true
                    }
                }
            }
        }
        return false
    }
    
    mutating func isCheckmate(for color: PieceColor) -> Bool {
        if !isKingInCheck(for: color) {
            print("No checkmate: King is not in check.")
            return false
        }
        
        let kingPosition = findKing(for: color)
        
        // 1. can we move out
        if canKingEscape(from: kingPosition, color: color) {
            print("No checkmate: King can escape.")
            return false
        }
        
        // 2. Identify all attackers
        var attackingPieces: [(ChessPiece, (Int, Int))] = []
        for row in 0..<8 {
            for col in 0..<8 {
                if let piece = board[row][col], piece.color != color, piece.canMove(to: kingPosition, board: self) {
                    attackingPieces.append((piece, (row, col)))
                }
            }
        }
        
        // 3. If multiple attackers, only king movement can save it
        if attackingPieces.count > 1 {
            print("Checkmate detected: Multiple attackers.")
            return true
        }
        
        let (attacker, attackerPosition) = attackingPieces.first!
        
        // 4. Can we capture
        for row in 0..<8 {
            for col in 0..<8 {
                if let piece = board[row][col], piece.color == color, piece.canMove(to: attackerPosition, board: self) {
                    // Simulate capturing
                    let originalPiece = board[attackerPosition.0][attackerPosition.1]
                    board[attackerPosition.0][attackerPosition.1] = piece
                    board[row][col] = nil
                    
                    // Is king still in check after attacking the opp
                    let stillInCheck = isKingInCheck(for: color)
                    
                    // Undo the move
                    board[row][col] = piece
                    board[attackerPosition.0][attackerPosition.1] = originalPiece
                    
                    if !stillInCheck {
                        print("No checkmate: Attacker can be captured.")
                        return false // Attacker can be captured
                    }
                }
            }
        }
        
        // 5. Can we block
        if attacker.type == .rook || attacker.type == .bishop || attacker.type == .queen {
            let attackPath = getPathBetween(attackerPosition, kingPosition)
            
            for row in 0..<8 {
                for col in 0..<8 {
                    if let piece = board[row][col], piece.color == color {
                        for blockPosition in attackPath {
                            // Simulate blocking
                            let originalPiece = board[blockPosition.0][blockPosition.1]
                            board[blockPosition.0][blockPosition.1] = piece
                            board[row][col] = nil
                            
                            // is king still in attack
                            let stillInCheck = isKingInCheck(for: color)
                            
                            // Undo the move
                            board[row][col] = piece
                            board[blockPosition.0][blockPosition.1] = originalPiece
                            
                            if !stillInCheck && piece.canMove(to: blockPosition, board: self) {
                                print("No checkmate: Attack can be blocked.")
                                return false // Blocking move found
                            }
                        }
                    }
                }
            }
        }
        
        print("Checkmate detected: No escape, capture, or block possible.")
        return true // No solution only means CHECK MAKTE
    }
    
    func getPathBetween(_ from: (Int, Int), _ to: (Int, Int)) -> [(Int, Int)] {
        var path: [(Int, Int)] = []
        let (startRow, startCol) = from
        let (endRow, endCol) = to
        
        let rowStep = (endRow > startRow) ? 1 : (endRow < startRow) ? -1 : 0
        let colStep = (endCol > startCol) ? 1 : (endCol < startCol) ? -1 : 0
        
        var currentRow = startRow + rowStep
        var currentCol = startCol + colStep
        
        while (currentRow, currentCol) != (endRow, endCol) {
            path.append((currentRow, currentCol))
            currentRow += rowStep
            currentCol += colStep
        }
        
        return path
    }
    
    private func findKing(for color: PieceColor) -> (Int, Int) {
        for row in 0..<8 {
            for col in 0..<8 {
                if let piece = board[row][col], piece.type == .king, piece.color == color {
                    return (row, col)
                }
            }
        }
        fatalError("King not found on the board!")
    }
    
    private mutating func canKingEscape(from position: (Int, Int), color: PieceColor) -> Bool {
        let (row, col) = position
        let directions = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),          (0, 1),
            (1, -1), (1, 0), (1, 1)
        ]
        
        for (dx, dy) in directions {
            let newRow = row + dx
            let newCol = col + dy
            
            if newRow >= 0, newRow < 8, newCol >= 0, newCol < 8 {
                if board[newRow][newCol] == nil || board[newRow][newCol]?.color != color {
                    // Simulate the king moving
                    let originalPiece = board[newRow][newCol]
                    board[newRow][newCol] = board[row][col]
                    board[row][col] = nil
                    
                    let stillInCheck = isKingInCheck(for: color)
                    
                    // Undo move
                    board[row][col] = board[newRow][newCol]
                    board[newRow][newCol] = originalPiece
                    
                    if !stillInCheck {
                        return true // The king can escape
                    }
                }
            }
        }
        
        return false // No escape moves available
    }
    
    private func printBoardSetup() {
        print("Chess Board:")
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
