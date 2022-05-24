//
//  Friend.swift
//  shopimize
//
//  Created by Mircea Egry on 18/04/2022.
//

import Foundation
import FirebaseFirestore

/// This struct contains all friend properties.
/// Conforms to Codable so the object can easily be encoded and decoded online

struct Friend: Codable{
    var friendship: [String]
    var createdAt: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case friendship
        case createdAt = "created_at"
    }
}
