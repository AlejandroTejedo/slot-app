//
//  UserService.swift
//  GoSlotNativa
//
//  Created by Alejandro on 16/11/21.
//

import SwiftUI
import Firebase

struct UserService {
    
    static func follow(uid: String, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("siguiendo").document(currentUid).collection("usuario-siguiendo").document(uid).setData([:]) { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("seguidores").document(uid).collection("seguidores-usuario").document(currentUid).setData([:], completion: completion)
                
                
                
        }
            
    }
    
    static func unfollow(uid: String, completion: ((Error?) -> Void)?) {
        
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("seguidores").document(uid).collection("seguidores-usuario").document(uid).delete { (err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("seguidores").document(uid).collection("seguidores-usuario").document(currentUid).delete(completion: completion)
        }
    }
    
    static  func checkFollow(userId: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        Firestore.firestore().collection("siguiendo").document(currentUid).collection("usuario-siguiendo").document(userId).getDocument { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let didFollow = snap?.exists else { return }
            
            completion(didFollow)
        }
    }
    
}
