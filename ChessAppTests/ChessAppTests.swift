//
//  ChessBoardTests.swift
//  ChessAppTests
//
//  Created by Oscar on 2025-02-17.
//

import Testing
@testable import ChessApp

struct ChessBoardTests {
    
    @Test func testInitialBoardSetup() async throws {
        let board = ChessBoard()
        
    
        for col in 0..<8 {
            #expect(board.board[1][col]?.type == .pawn)
            #expect(board.board[1][col]?.color == .black)
            #expect(board.board[6][col]?.type == .pawn)
            #expect(board.board[6][col]?.color == .white)
        }
        
   
        #expect(board.board[0][0]?.type == .rook)
        #expect(board.board[0][7]?.type == .rook)
        #expect(board.board[7][0]?.type == .rook)
        #expect(board.board[7][7]?.type == .rook)
    }

    @Test func testValidPawnMove() async throws {
        var board = ChessBoard()
        
        let moveSuccess = board.movePiece(from: (6, 4), to: (4, 4))
        #expect(moveSuccess)
        #expect(board.board[4][4]?.type == .pawn)
        #expect(board.board[4][4]?.color == .white)
        #expect(board.board[6][4] == nil)
    }
    
    @Test func testInvalidMoveWrongTurn() async throws {
        var board = ChessBoard()
        
        let moveSuccess = board.movePiece(from: (1, 4), to: (3, 4))
        #expect(!moveSuccess)
        #expect(board.board[1][4]?.type == .pawn)
    }
    
    @Test func testKnightMovement() async throws {
        var board = ChessBoard()
        
        let moveSuccess = board.movePiece(from: (7, 1), to: (5, 2))
        #expect(moveSuccess)
        #expect(board.board[5][2]?.type == .knight)
        #expect(board.board[5][2]?.color == .white)
        #expect(board.board[7][1] == nil)
    }
    
    @Test func testInvalidKnightMove() async throws {
        var board = ChessBoard()
        
        let moveSuccess = board.movePiece(from: (7, 1), to: (6, 1))
        #expect(!moveSuccess)
        #expect(board.board[7][1]?.type == .knight)
    }

    @Test func testCheckDetection() async throws {
        var board = ChessBoard()
        
    
        _ = board.movePiece(from: (6, 5), to: (5, 5))
        _ = board.movePiece(from: (1, 4), to: (3, 4))
        _ = board.movePiece(from: (6, 6), to: (4, 6))
        _ = board.movePiece(from: (0, 3), to: (4, 7))
        
        #expect(board.isKingInCheck(for: .white))
    }
}
