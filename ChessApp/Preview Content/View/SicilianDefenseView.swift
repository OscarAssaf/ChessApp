//
//  SicilianDefenseView.swift
//  ChessApp
//
//  Created by Oscar Assaf on 2025-03-10.
//

import Foundation
import SwiftUI

struct SicilianDefenseView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("The Sicilian Defense is one of the most popular and aggressive responses to 1.e4.")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                
                if let image = UIImage(named: "sicilian", in: Bundle.main, compatibleWith: nil) {
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
                Text("Move order:")
                    .font(.headline)
                    .padding(.top, 10)
                VStack(alignment: .leading, spacing: 5){
                    Text("White 1: Pawn from e2 to e4.")
                    Text("Black 1: Pawn from c7 to c5.")
                    Text("White 2: Knight from g1 to f3.")
                    Text("Black 2: Pawn from d7 to d6.")
                }
                
                Text("Why this is good:")
                    .font(.headline)
                    .padding(.top, 5)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("1. Control the d4 square with the c5 pawn.")
                    Text("2. Develop your pieces quickly, especially the knights and bishops.")
                    Text("3. Aim for counterplay on the queenside.")
                }
                .font(.body)
            }
            .padding()
        }
        .navigationTitle("Sicilian Defense")
    }
}

