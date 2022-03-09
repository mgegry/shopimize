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
    
}
