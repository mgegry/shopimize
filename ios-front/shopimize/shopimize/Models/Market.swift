//
//  Market.swift
//  shopimize
//
//  Created by Mircea Egry on 09/03/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

/// This struct contains all market properties.
/// Conforms to Codable so the object can easily be encoded and decoded online

struct Market: Codable, Identifiable {
    
    @DocumentID var id: String? = UUID().uuidString
    var shopName: String?
    var createdAt: Timestamp
    var isActive: Bool
    var storeID: String?
    
    /// Enum containing the coding key of each field
    enum CodingKeys: String, CodingKey {
        case id = "documentID"
        case shopName = "shopname"
        case createdAt = "created_at"
        case isActive = "is_active"
        case storeID
    }
}
