//
//  PlaceResponse.swift
//  shopimize
//
//  Created by Mircea Egry on 03/04/2022.
//

import Foundation

class Candidate: Codable {
    var formattedAddress: String
    var geometry: Geometry
    var name: String
    var rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case geometry
        case name
        case rating
    }
}

class PlaceResponce: Codable {
    var candidates: [Candidate]
    var status: String
}
