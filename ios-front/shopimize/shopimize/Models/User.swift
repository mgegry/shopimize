//
//  User.swift
//  shopimize
//
//  Created by Mircea Egry on 09/03/2022.
//

import Foundation
import FirebaseFirestoreSwift

/// This struct contains all user properties.
/// Conforms to Codable so the object can easily be encoded and decoded online

struct User: Codable  {
    @DocumentID var id: String? = UUID().uuidString
    var username: String?
    var points: Int?
    var role: String
    var roleStoreID: String?
    
    /// Enum containing the coding key for each field
    enum CodingKeys: String, CodingKey {
        case id = "documentID"
        case username
        case points
        case role
        case roleStoreID = "role_store_id"
    }
}
