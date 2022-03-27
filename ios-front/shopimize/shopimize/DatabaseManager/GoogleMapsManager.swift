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
    
    private let apiKey = "AIzaSyDZtCb83OMuZbz3Npqrlfm378VajVG2Z20"
    private var decodeURL: String = "https://maps.googleapis.com/maps/api/geocode/json"
    
    private init() {}
    
    func decodeAddressToLocation(address: String, city: String, postalcode: String,
                                 completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> ()) {
        
        var location = CLLocationCoordinate2D()
        
        let updatedAddress = address.replacingOccurrences(of: " ", with: "%20")
        let updatedCity = city.replacingOccurrences(of: " ", with: "%20")
        let updatedPostcode = postalcode.replacingOccurrences(of: " ", with: "%20")
        
        let searchAddress = updatedAddress + "%20" + updatedCity + "%20" + updatedPostcode
        
        let requestUrl = decodeURL + "?address=" + searchAddress + "&key=" + apiKey
        
        let task = URLSession.shared.dataTask(with: URL(string: requestUrl)!) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let locationRequest = try decoder.decode(LocationRequest.self, from: data)
                location.longitude = locationRequest.results[0].geometry.location.lng
                location.latitude = locationRequest.results[0].geometry.location.lat
                completion(.success(location))
            } catch let error {
                completion(.failure(error))
            }
            
        }
        task.resume()
        
    }
}
