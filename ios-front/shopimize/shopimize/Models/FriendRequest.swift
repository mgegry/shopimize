//
//  FriendRequest.swift
//  shopimize
//
//  Created by Mircea Egry on 18/04/2022.
//

import Foundation

struct FriendRequest: Codable{
    var userOne: String
    var userTwo: String
    
    enum CodingKeys: String, CodingKey {
        case userOne = "user_one"
        case userTwo = "user_two"
    }
}
