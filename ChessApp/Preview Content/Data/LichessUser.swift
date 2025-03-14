//
//  LichessUser.swift
//  ChessApp
//
//  Created by Oscar Assaf on 2025-03-03.
//

import Foundation

struct LichessUser: Decodable {
    let id: String
    let username: String
    let perfs: Perfs
    let url: String
    let playTime: PlayTime
    let count: Count
    
    struct Perfs: Decodable {
        let bullet: GameStats
        let blitz: GameStats
        let rapid: GameStats
        let puzzle: GameStats
    }
    
    struct GameStats: Decodable {
        let games: Int
        let rating: Int
    }
    
    
    
    struct PlayTime: Decodable {
        let total: Int
    }
    
    struct Count: Decodable {
        let all: Int
        let win: Int
        let loss: Int 
    }
}
