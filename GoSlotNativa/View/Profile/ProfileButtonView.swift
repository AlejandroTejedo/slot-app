//
//  ProfileButtonView.swift
//  GoSlotNativa
//
//  Created by Alejandro on 26/10/21.
//

import SwiftUI

struct ProfileButtonView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var didFollow: Bool {
        return viewModel.user.didFollow ?? false
    }
    
    var body: some View {
        
        if viewModel.user.isCurrentUser {
            Button {
                
            } label: {
                
                Text("Editar perfil")
                    .font(.system(size: 14, weight: .semibold))
                    .frame(width: 360, height: 36)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
            }

        }
        else {
            HStack(spacing: 16) {
                Button {
                    didFollow ? viewModel.unfollow() : viewModel.follow()
                } label: {
                    
                    Text(didFollow ? "Siguiendo" : "Seguir")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 172, height: 32)
                        .foregroundColor(didFollow ? .black : .white)
                        .background(didFollow ? Color.white : Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: didFollow ? 1 : 0)
                        )
                }.cornerRadius(3)
                
                if let userId = viewModel.user.id {
                    NavigationLink(destination: MessageChatView(userId: userId)) {
                        Text("Mensaje")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 172, height: 36)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
            }
        }
        
        
    }
}

