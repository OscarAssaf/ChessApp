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
    @Test func testTurnManagement() async throws {
        var board = ChessBoard()
        
        let moveSuccess1 = board.movePiece(from: (6, 4), to: (5, 4))
        #expect(moveSuccess1)
        #expect(board.currentTurn == .black)
        
    
        let moveSuccess2 = board.movePiece(from: (1, 4), to: (3, 4))
        #expect(moveSuccess2)
        #expect(board.currentTurn == .white)
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
    
    @Test func testValidRookMove() async throws {
        var board = ChessBoard()
        _ = board.movePiece(from: (0,1), to: (0, 3))
        _ = board.movePiece(from: (0,0), to: (0,2))
        _ = board.movePiece(from: (0,2), to: (0,0))
        #expect(board.board[0][0]?.type == .rook)
        #expect(board.board[0][0]?.color == .black)
    }
    
    @Test func testRookMovementBlocked() async throws {
        var board = ChessBoard()
        
        let moveBlocked = board.movePiece(from: (7, 0), to: (5, 0))
        #expect(!moveBlocked)
    }

    
    // 10. Test Invalid Bishop Move (Blocked)
    @Test func testInvalidBishopMoveBlocked() async throws {
        var board = ChessBoard()
        let moveSuccess = board.movePiece(from: (7, 2), to: (5, 4))
        #expect(!moveSuccess)
        #expect(board.board[7][2]?.type == .bishop)
    }
    
    @Test func Testingking () async throws {
        
        
        var board = ChessBoard()
        
        _ = board.movePiece(from: (6, 3), to: (5, 3))
        _ = board.movePiece(from: (1, 3), to: (2, 3))
        _ = board.movePiece(from: (7, 3), to: (6, 3))

        
        #expect(board.board[6][3]?.color == .white)
        #expect(board.board[6][3]?.type == .king)
    }
   
    
    @Test func testMoveToSamePosition() async throws {
        var board = ChessBoard()
        let moveSuccess = board.movePiece(from: (7, 0), to: (7, 0))
        #expect(!moveSuccess)
    }
    
    @Test func testMoveNonexistentPiece() async throws {
        var board = ChessBoard()
        let moveSuccess = board.movePiece(from: (3, 3), to: (4, 4))
        #expect(!moveSuccess)
    }
    
    @Test func testTakePawn() async throws{
            var board = ChessBoard()
            _ = board.movePiece(from: (6, 3), to: (4, 3))
            _ = board.movePiece(from: (1, 4), to: (3, 4))
            _ = board.movePiece(from: (4, 3), to: (3, 4))

            #expect(board.board[3][4]?.color == .white)
            #expect(board.board[4][3] == nil)
        }
        @Test func testCheckScenario() async throws {
            var board = ChessBoard()
            _ = board.movePiece(from: (6, 4), to: (4, 4))
            _ = board.movePiece(from: (1, 5), to: (3, 5))
            _ = board.movePiece(from: (6, 5), to: (4, 5))
            _ = board.movePiece(from: (0, 4), to: (3, 7))

            let isWhiteInCheck = board.isKingInCheck(for: .white)
            #expect(isWhiteInCheck)
        }
        @Test func testCHeckmateScenario() async throws {
            var board = ChessBoard()
            _ = board.movePiece(from: (6, 2), to: (5, 2))
            _ = board.movePiece(from: (1, 3), to: (2, 3))
            _ = board.movePiece(from: (6, 1), to: (4, 1))
            _ = board.movePiece(from: (0, 4), to: (4, 0))

            let isCheckmate = board.isCheckmate(for: .white)
            #expect(isCheckmate)
        }
    

    

}
