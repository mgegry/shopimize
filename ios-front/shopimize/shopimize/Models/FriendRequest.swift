//
//  FriendRequest.swift
//  shopimize
//
//  Created by Mircea Egry on 18/04/2022.
//

import Foundation
import FirebaseFirestore

struct FriendRequest: Codable {
    var fromUser: String
    var toUser: String
    var createdAt: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case fromUser = "from_user"
        case toUser = "to_user"
        case createdAt = "created_at"
    }
}
