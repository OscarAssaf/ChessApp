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

                Text("The Sicilian Defense is one of the most popular and aggressive responses to 1.e4.")
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

                Text("Why this is good:")
                    .font(.headline)
                    .padding(.top, 10)

                VStack(alignment: .leading, spacing: 10) {
                    Text("1. Control the d4 square with the c5 pawn.")
                    Text("2. Develop your pieces quickly, especially the knights and bishops.")
                    Text("3. Aim for counterplay on the queenside.")
                }
                .font(.body)
            }
            .padding()
        }
        .navigationTitle("English Opening")
    }
}

