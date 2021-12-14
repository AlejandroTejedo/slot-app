//
//  FeedCellViewModel.swift
//  GoSlotNativa
//
//  Created by Alejandro on 16/11/21.
//

import SwiftUI
import Firebase

class FeedCellViewModel: ObservableObject {
    
    @Published var post:Post
    
    init(post:Post) {
        self.post = post
        fetchUser()
    }
    
    func fetchUser() {
        Firestore.firestore().collection("usuarios").document(post.ownerUid).getDocument { (snap, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            self.post.user = try? snap?.data(as: User.self)
            
            guard let userImageURL = self.post.user?.profileImageURL else { return }
            self.post.ownerImageURL = userImageURL
            
        }
    }
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
}
