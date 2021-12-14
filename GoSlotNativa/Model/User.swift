//
//  User.swift
//  GoSlotNativa
//
//  Created by Alejandro on 25/10/21.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Decodable, Identifiable {
    let username: String
    let email: String
    var profileImageURL: String?
    @DocumentID var id: String?
    var stats: UserStatsData?
    var isCurrentUser: Bool {
        return AuthViewModel.shared.userSession?.uid == id
    }
    
    var didFollow: Bool? = false
}

struct UserStatsData: Decodable {
    var following: Int
    var followers: Int
    var posts: Int
}
