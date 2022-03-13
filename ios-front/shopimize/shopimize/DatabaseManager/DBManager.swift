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

class DBManager {
    static let shared = DBManager()
    
    /// Firebase Firestore database object
    private let userCollection = FirebaseReferences.db.collection("User")
    private let marketCollection = FirebaseReferences.db.collection("Market")
    
    private init() { }
    
    // MARK: Handle users Firestore
    
    /// Add user to Firebase Firestore after sign up
    ///
    /// - parameter email: The user email
    /// - parameter user: An user object containing user information
    /// - parameter completion: Escaping closure receiving operation result as boolean
    func addUserFirestore(with email: String, user: User, completion: @escaping (Bool) -> ()) {
        do {
            try userCollection.document(email).setData(from: user)
            completion(true)
        } catch let error {
            print("Error wirting user to Firestore: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    // MARK: Handle markets Firestore
    
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
                        print(market)
                    case .failure(let error):
                        print("[error]:: can not get document in markets collection -- \(error.localizedDescription)")
                        
                    }
                }
                completion(.success(markets))
            }
        }
    }
}
