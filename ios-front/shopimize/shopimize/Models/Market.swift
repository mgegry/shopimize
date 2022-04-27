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
    var street: String
    var postalCode: String
    var city: String
    var geoLocation: GeoPoint
    var createdAt: Timestamp
    var isActive: Bool
    var storeID: String
    var storeName: String?
    
    /// Enum containing the coding key of each field
    enum CodingKeys: String, CodingKey {
        case id = "documentID"
        case street = "street"
        case postalCode = "postal_code"
        case city = "city"
        case geoLocation = "geo_location"
        case createdAt = "created_at"
        case isActive = "is_active"
        case storeID
    }
}
