//
//  Friend.swift
//  shopimize
//
//  Created by Mircea Egry on 18/04/2022.
//

import Foundation
import FirebaseFirestore

struct Friend: Codable{
    var friendship: [String]
    var createdAt: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case friendship
        case createdAt = "created_at"
    }
}
