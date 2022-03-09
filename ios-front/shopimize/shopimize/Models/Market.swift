//
//  Market.swift
//  shopimize
//
//  Created by Mircea Egry on 09/03/2022.
//

import Foundation

struct Market {
    var shopName: String
    var createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case shopName = "shopname"
        case createdAt = "created_at"
    }
}

extension Market: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(shopName, forKey: .shopName)
        try container.encode(createdAt, forKey: .createdAt)
    }
}

extension Market: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        shopName = try values.decode(String.self, forKey: .shopName)
        createdAt = try values.decode(Date.self, forKey: .createdAt)
    }
}
