//
//  ProfileView.swift
//  GoSlotNativa
//
//  Created by Alejandro on 24/10/21.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                logOutButton
                ProfileHeaderView(viewModel: ProfileViewModel(user: user))
                    
                
                if let currentProfileID = user.id {
                    PostGridView(config: .profile(currentProfileID))
                }
            }
            .padding(.top)
            
        }
    }
    
    
    var logOutButton: some View {
        Button {
            AuthViewModel.shared.logout()
        } label: {
            Text("Desconectarse").foregroundColor(.blue)
        }
    }
    
}
