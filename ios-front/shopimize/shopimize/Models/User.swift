//
//  User.swift
//  shopimize
//
//  Created by Mircea Egry on 09/03/2022.
//

import Foundation

/// This struct contains all user properties.
/// Conforms to Codable so the object can easily be encoded and decoded online

struct User: Codable  {
    var email: String?
    var firstName: String?
    var lastName: String?
    var role: String?
    
    /// Enum containing the coding key for each field
    enum CodingKeys: String, CodingKey {
        case firstName = "firstname"
        case lastName = "lastname"
        case role
    }
}
