//
//  User.swift
//  shopimize
//
//  Created by Mircea Egry on 09/03/2022.
//

import Foundation

struct User {
    var firstName: String
    var lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstname"
        case lastName = "lastname"
    }
}

extension User: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
    }
    
}

extension User: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
    }
}
