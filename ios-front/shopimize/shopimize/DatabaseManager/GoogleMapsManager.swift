//
//  GoogleMapsManager.swift
//  shopimize
//
//  Created by Mircea Egry on 27/03/2022.
//

import Foundation
import CoreLocation


/// Singleton class to manage Google Maps APIs
class GoogleMapsManager {
    
    static let shared = GoogleMapsManager()
    
    private let apiKey = "AIzaSyDZtCb83OMuZbz3Npqrlfm378VajVG2Z20"
    private var decodeURL: String = "https://maps.googleapis.com/maps/api/geocode/json"
    private var getPlaceURL: String = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json"
    
    private init() {}
    
    /// Decodes lan and long for a given text address
    ///
    /// - parameter address: the address
    /// - parameter city: the city
    /// - parameter postalcode: the postal code
    /// - parameter completion: Escaping closure taking a CLLocationCoordinate2D  as a parameter when the request finishes
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
