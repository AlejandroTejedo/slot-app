//
//  ProfileHeaderView.swift
//  GoSlotNativa
//
//  Created by Alejandro on 24/10/21.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    
    @State var selectedImage: UIImage?
    @State var userImage: Image? = Image("profile-placeholder")
    @State var imagePickerRepresented = false
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                ZStack {
                    if let imageURL = viewModel.user.profileImageURL {
                        Button {
                            self.imagePickerRepresented.toggle()
                        } label: {
                            KFImage(URL(string: imageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.leading, 16)
                        }.sheet(isPresented: $imagePickerRepresented, onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedImage)
                        })

                    }
                    else {
                        Button {
                            self.imagePickerRepresented.toggle()
                        } label: {
                            userImage?
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.leading, 16)
                        }.sheet(isPresented: $imagePickerRepresented, onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedImage)
                        })

                    }
                }
                
                
                HStack(spacing: 16) {
                    UserStats(value: viewModel.user.stats?.followers ?? 0, title: "Seguidores")
                    UserStats(value: viewModel.user.stats?.following ?? 0, title: "Siguiendo")
                }.padding(.trailing, 32)
                
            }
            
            Text(viewModel.user.username ?? "")
                .font(.system(size: 15, weight: .bold))
                .padding([.leading, .top])
                .padding(.leading, 20)
            
            HStack {
                Spacer()
                ProfileButtonView(viewModel: viewModel)
                Spacer()
            }.padding(.top)
            
        }
    }
}

extension ProfileHeaderView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        userImage = Image(uiImage: selectedImage)
        viewModel.changeProfileImage(image: selectedImage) { (_) in
            print("DEBUG: Upload Image")
        }
    }
}
