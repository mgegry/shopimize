//
//  DBManager.swift
//  shopimize
//
//  Created by Mircea Egry on 09/03/2022.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseCore
import Foundation

/// Singleton class that handles Firebase Firestore communication

class DBMarketManager {
    static let shared = DBMarketManager()
    
    /// Firebase Firestore database object
    private let marketCollection = FirebaseReferences.db.collection("Market")
    
    private init() { }
    
    /// Add a market to Firebase Firestore
    ///
    /// - parameter market: An object containing market information
    /// - parameter completion: Escaping closure receiving operationt result as boolean
    func addMarketFirestore(market: Market, completion: @escaping (Bool) -> ()) {
        do {
            let _ = try marketCollection.addDocument(from: market)
            completion(true)
        } catch let error {
            print("[error]:: adding market to firestore DB -- \(error.localizedDescription)")
            completion(false)
        }
    }
    
    /// Get all markets in Market collection Firebase Firestore
    ///
    /// - parameter completion: Escaping closure receiving as parameter a result object
    func getAllMarketsFirestore(completion: @escaping (Result<[Market], Error>) -> ()) {
        
        var markets: [Market] = []
        
        marketCollection.getDocuments { querySnapshot, error in
            if let error = error {
                print("[error]:: getting all markets firestore DB -- \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                
                // TODO: Make sure querySnapshot exists
                
                for document in querySnapshot!.documents {
                    let result = Result {
                        try document.data(as: Market.self)
                    }
                    
                    switch result {
                    case .success(let market):
                        markets.append(market)
                    case .failure(let error):
                        print("[error]:: can not get document in markets collection -- \(error.localizedDescription)")
                        
                    }
                }
                completion(.success(markets))
            }
        }
    }
    
    func getAllActiveMarketsFirestore(completion: @escaping (Result<[Market], Error>) -> ()) {
        var markets: [Market] = []
        
        marketCollection.whereField("is_active", isEqualTo: true).getDocuments { querySnapshot, error in
            guard let snapshot = querySnapshot, error == nil else {
                print("[error]:: getting all active items firestore -- \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            
            for document in snapshot.documents {
                let result = Result {
                    try document.data(as: Market.self)
                }
                
                switch result {
                    case .success(let success):
                        markets.append(success)
                    case .failure(let failure):
                        print("[error]:: document in item collection can not be decoded -- \(failure.localizedDescription)")
                }
            }
            completion(.success(markets))
        }
    }
}
