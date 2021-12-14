//
//  ProfileViewModel.swift
//  GoSlotNativa
//
//  Created by Alejandro on 25/10/21.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkFollow()
        checkStats()
    }
    
    func changeProfileImage(image: UIImage, completion: @escaping(String) -> Void) {
        
        guard let uid = user.id else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageURL in
            
            Firestore.firestore().collection("usuarios").document(uid).updateData(["profileImageURL": imageURL]) { err in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                self.user.profileImageURL = imageURL
                
            }
            
        }
        
    }
    
    func follow(uid: String) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("siguiendo").document(currentUid).collection("usuario-siguiendo").document(uid).setData([:]) { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("seguidores").document(uid).collection("seguidores-usuario").document(currentUid).setData([:]) { (err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                
                
            }
            
        }
    }
    
    func follow() {
        guard let userId = user.id else { return }
        
        UserService.follow(uid: userId) { (err) in
            if let err = err {
                print(err.localizedDescription)
                
                return
            }
            NotificationsViewModel.sendNotification(withUid: userId, type: .follow)
            self.user.didFollow = true
        }
    }
    
    func unfollow() {
        guard let userId = user.id else { return }
        
        UserService.unfollow(uid: userId) { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            self.user.didFollow = false
        }
    }
    
    func checkFollow() {
        guard !user.isCurrentUser else { return }
        
        guard let userId = user.id else { return }
        
        UserService.checkFollow(userId: userId) { didFollow in
            self.user.didFollow = didFollow
        }
    }
    
    func checkStats() {
        
        guard let userId = user.id else { return }
        
        Firestore.firestore().collection("seguidores").document(userId).collection("seguidores-usuario").getDocuments { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let followers = snap?.documents.count else { return }
            
            Firestore.firestore().collection("siguiendo").document(userId).collection("usuario-siguiendo").getDocuments { (snap, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                
                guard let following = snap?.documents.count else { return }
                
                Firestore.firestore().collection("posts").whereField("ownerUid", isEqualTo: userId).getDocuments { (snap, err) in
                    if let err = err {
                        print(err.localizedDescription)
                        return
                    }
                    
                    guard let posts = snap?.documents.count else { return }
                    
                    self.user.stats = UserStatsData(following: following, followers: followers, posts: posts)
                }
            }
            
        }
    }
    
}
