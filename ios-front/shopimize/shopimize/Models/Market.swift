//
//  Market.swift
//  shopimize
//
//  Created by Mircea Egry on 09/03/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Market: Codable, Identifiable {
    
    @DocumentID var id: String? = UUID().uuidString
    var shopName: String?
    var createdAt: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case shopName = "shopname"
        case createdAt = "created_at"
    }
}

//extension Market: Encodable {
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(shopName, forKey: .shopName)
//        try container.encode(createdAt, forKey: .createdAt)
//        try container.encode(marketID, forKey: .marketID)
//    }
//}
//
//extension Market: Decodable {
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        shopName = try values.decode(String.self, forKey: .shopName)
//        createdAt = try values.decode(Timestamp.self, forKey: .createdAt)
//        marketID = try values.decode(String.self, forKey: .marketID)
//    }
//}
