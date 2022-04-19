//
//  FriendRequest.swift
//  shopimize
//
//  Created by Mircea Egry on 18/04/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FriendRequest: Codable {
    @DocumentID var id: String? = UUID().uuidString
    var fromUser: String
    var toUser: String
    var createdAt: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case id = "documentID"
        case fromUser = "from_user"
        case toUser = "to_user"
        case createdAt = "created_at"
    }
}
