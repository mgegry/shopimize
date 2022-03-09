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

class DBManager {
    static let shared = DBManager()
    
    private let db = Firestore.firestore()
    
    private init() { }
    
    
    
    // HANDLE USERS SECTION
    
    func addUserFirestore(with email: String, user: User, completion: @escaping (Bool) -> ()) {
        do {
            try db.collection("User").document(email).setData(from: user)
            completion(true)
        } catch let error {
            print("Error wirting user to Firestore: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    // HANDLE MARKETS SECTION
    
    func addMarketFirestore(market: Market, completion: @escaping (Bool) -> ()) {
        do {
            let _ = try db.collection("Market").addDocument(from: market)
            completion(true)
        } catch let error {
            print("[error]:: adding user to firestore DB -- \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func getAllMarketsFirestore(completion: @escaping (Result<[Market], Error>) -> ()) {
        
        var markets: [Market] = []
        
        db.collection("Market").getDocuments { querySnapshot, error in
            if let error = error {
                print("[error]:: getting all markets firestore DB -- \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                
                for document in querySnapshot!.documents {
                    let result = Result {
                        try document.data(as: Market.self)
                    }
                    
                    switch result {
                    case .success(let market):
                        markets.append(market)
                    case .failure(let error):
                        print("[error]:: can not get document in markets collection -- \(error)")
                        
                    }
                }
                completion(.success(markets))
            }
            
        }
    }
    
}
