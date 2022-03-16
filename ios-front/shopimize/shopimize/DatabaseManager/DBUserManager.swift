//
//  DBUserManager.swift
//  shopimize
//
//  Created by Mircea Egry on 16/03/2022.
//

import Foundation
import FirebaseFirestore

/// Singleton class handeling FIrebase Firestore communication related to the user collection
class DBUserManager {
    
    static let shared = DBUserManager()
    
    /// Get reference to user collection
    private var userCollection = FirebaseReferences.db.collection("User")
    
    /// Singleton class so private initializer
    private init() { }
    
    /// Get user from user collection firesgtore with provided email
    ///
    /// - parameter email: The email of the user
    /// - parameter completion: Escaping closure which is provided a result as a parameter when the method execution ends
    func getUserFirestore(withEmail email: String, completion: @escaping (Result<User, Error>) -> ()) {
        
        userCollection.document(email).getDocument(as: User.self, completion: { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                print("\(failure.localizedDescription)")
                completion(.failure(failure))
            }
            
        })
    }
        
}

