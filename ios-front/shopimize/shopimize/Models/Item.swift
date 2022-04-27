//
//  Item.swift
//  shopimize
//
//  Created by Mircea Egry on 12/03/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

/// This struct contains all item properties.
/// Conforms to Codable so the object can easily be encoded and decoded online

struct Item: Codable, Identifiable {
    @DocumentID var id: String? = UUID().uuidString
    var itemName: String
    var price: Double
    var marketID: String
    var description: String?
    var createdAt: Timestamp
    var isActive: Bool
    var imageURL: String?
    
    /// Enum containing the coding key for each field
    enum CodingKeys: String, CodingKey {
        case id = "documentID"
        case itemName = "item_name"
        case price = "price"
        case marketID = "market_id"
        case description
        case createdAt = "created_at"
        case isActive = "is_active"
        case imageURL
    }
}
