//
//  UploadPostView.swift
//  GoSlotNativa
//
//  Created by Alejandro on 24/10/21.
//

import SwiftUI

struct UploadPostView: View {
    
    @State private var selectedImage: UIImage?
    @State var postImage: Image?
    @State var captionText = ""
    @State var imagePickerRepresented = false
    @ObservedObject var viewModel = UploadPostViewModel()
    
    var body: some View {
        
        if postImage == nil {
            
            Button {
                self.imagePickerRepresented.toggle()
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 180)
                    .clipped()
                    .padding(.top)
                    .foregroundColor(.black)
            }.sheet(isPresented: $imagePickerRepresented){
                loadImage()
            } content: {
                ImagePicker(image: $selectedImage)
            }
            
        }
        
        else if let image = postImage {
            VStack {
                HStack(alignment: .top) {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .clipped()
                    
                    TextArea(text: $captionText, placeholder: "Introduce tu descripción...")
                }
                .padding()
                
                Button {
                    if let image = selectedImage {
                        viewModel.uploadPost(image: image, caption: captionText)
                        
                        captionText = ""
                        postImage = nil
                    }
                    
                } label: {
                    Text("Publicar")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 360, height: 50)
                        .background(Color.blue)
                        .cornerRadius(5)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
        }
        
    }
}

extension UploadPostView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}
