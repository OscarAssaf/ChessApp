//
//  ProfileView.swift
//  ChessApp
//
//  Created by Oscar Assaf on 2025-02-21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .padding()
            
           
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            
            Text("Username: OscarChessMaster")
            Text("Elo Rating: 1500")
        }
    }
}

#Preview {
    ProfileView()
}
