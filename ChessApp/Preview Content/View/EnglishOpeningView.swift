//
//  EnglishOpeningView.swift
//  ChessApp
//
//  Created by Torik Runhall on 2025-03-12.
//

import Foundation
import SwiftUI

struct EnglishOpeningView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                Text("The English Opening (1. c4) is a flexible and strategic opening that allows White to dictate the pace of the game and control the center with a flank pawn.")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                
                if let image = UIImage(named: "English", in: Bundle.main, compatibleWith: nil) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding(.vertical, 10)
                } else {
                    Text("Image not found")
                        .foregroundColor(.red)
                        .padding(.vertical, 10)
                }

                Text("Move Order:")
                    .font(.headline)
                    .padding(.top, 10)

                VStack(alignment: .leading, spacing: 5) {
                    Text("1. c4 (White controls the center indirectly with a flank pawn).")
                    Text("2. g3 (White prepares to fianchetto the bishop for long-term control).")
                    Text("3. Bg2 (The fianchettoed bishop exerts strong control over the d5 and e4 squares).")
                    Text("4. Nf3 (White continues development, aiming for control and flexibility).")
                }

                Text("Why This is Good:")
                    .font(.headline)
                    .padding(.top, 5)

                VStack(alignment: .leading, spacing: 10) {
                    Text("1. Avoids immediate central pawn battles, leading to rich positional play.")
                    Text("2. Controls the d5 square early, limiting Black's pawn breaks.")
                    Text("3. Can transpose into multiple strong openings, such as the King's Indian Attack or the Réti Opening.")
                }
                .font(.body)
            }
            .padding()
        }
        .navigationTitle("English Opening")
    }
}
