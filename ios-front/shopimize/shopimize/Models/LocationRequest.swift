//
//  LocationRequest.swift
//  shopimize
//
//  Created by Mircea Egry on 26/03/2022.
//

import Foundation

struct Location: Codable {
    var lat: Double
    var lng: Double
}

struct Geometry: Codable {
    var location: Location
}

struct Place: Codable {
    var geometry: Geometry
}

struct LocationRequest: Codable {
    var results: [Place]
//    var status: String
}
