//
//  UploadPostViewModel.swift
//  GoSlotNativa
//
//  Created by Alejandro on 26/10/21.
//

import SwiftUI
import Firebase

class UploadPostViewModel: ObservableObject {
    
    func uploadPost(image: UIImage, caption: String) {
        
        guard let user = AuthViewModel.shared.currentUser else { return }
 
        ImageUploader.uploadImage(image: image, type: .post) { imageURL in
            guard let uid = user.id else { return }
            
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "imageURL": imageURL,
                        "ownerUid": uid,
                        "ownerUsername": user.username ] as [String : Any]
            
            BackendService.uploadPostBackend()
            
            Firestore.firestore().collection("publicaciones").addDocument(data: data) { err in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                
            }

        }
            }
        }
