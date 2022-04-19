//
//  FriendRequest.swift
//  shopimize
//
//  Created by Mircea Egry on 18/04/2022.
//

import Foundation
import FirebaseFirestore

struct FriendRequest: Codable {
    var request: [String]
    var createdAt: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case request
        case createdAt = "created_at"
    }
}
