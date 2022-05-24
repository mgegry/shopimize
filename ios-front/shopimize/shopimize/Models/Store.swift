//
//  Store.swift
//  shopimize
//
//  Created by Mircea Egry on 23/03/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

/// This struct contains all store properties.
/// Conforms to Codable so the object can easily be encoded and decoded online

struct Store: Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var isActive: Bool
    var createdAt: Timestamp
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "documentID"
        case name
        case isActive = "is_active"
        case createdAt = "created_at"
        case imageUrl = "imageURL"
    }
}
