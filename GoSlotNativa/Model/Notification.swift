//
//  Notifications.swift
//  GoSlotNativa
//
//  Created by Alejandro on 3/12/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Notification: Decodable, Identifiable {
    @DocumentID var id: String?
    var postId: String?
    var username: String
    var profileImageURL: String?
    var timestamp: Timestamp
    var uid: String
    var type: NotificationType
    
    
    var post: Post?
    var user: User?
    var didFollow: Bool? = false
}

enum NotificationType: Int, Decodable {
    case follow
    case comment
    case like
    case post
    
    var notificationsMessage: String {
        switch self {
        case .like:
            return " han dado me gust a tu foto"
        case .comment:
            return " hay un nuevo comentario"
        case .follow:
            return " ha empezado a seguirte"
        case .post:
            return " ha subido una nueva publicación"
        }
    }
}
