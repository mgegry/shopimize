//
//  GoogleMapsManager.swift
//  shopimize
//
//  Created by Mircea Egry on 27/03/2022.
//

import Foundation
import CoreLocation

class GoogleMapsManager {
    
    static let shared = GoogleMapsManager()
    
    private init() {}
    
    func decodeAddressToLocation(address: String, completion: @escaping (CLLocationCoordinate2D) -> ()) {
        
    }
}
