//
//  DBUserManager.swift
//  shopimize
//
//  Created by Mircea Egry on 16/03/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

/// Singleton class handeling FIrebase Firestore communication related to the user collection
class DBUserManager {
    
    static let shared = DBUserManager()
    
    /// Get reference to user collection
    private var userCollection = FirebaseReferences.db.collection("User")
    
    /// Singleton class so private initializer
    private init() { }
    
    /// Get user from user collection firestore with provided email
    ///
    /// - parameter email: The email of the user
    /// - parameter completion: Escaping closure which is provided a result as a parameter when the method execution ends
    func getUserFirestore(withEmail email: String, completion: @escaping (Result<User, Error>) -> ()) {
        
        userCollection.document(email).getDocument(as: User.self, completion: { result in
            switch result {
                case .success(let success):
                    completion(.success(success))
                case .failure(let failure):
                    print("[error]:: getting user firestore -- \(failure.localizedDescription)")
                    completion(.failure(failure))
            }
            
        })
    }
    
    /// Get the user role from firestore with provided email
    ///
    /// - parameter email: The email of the user
    /// - parameter completion: Escaping closure taking as parameter a result with the role and an error
    func getUserRoleFirestore(withEmail email: String, completion: @escaping (Result<String, Error>) -> ()) {
        userCollection.document(email).getDocument(as: User.self) { result in
            switch result {
                case .success(let user):
                    completion(.success(user.role.trimmingCharacters(in: .whitespacesAndNewlines)))
                case .failure(let failure):
                    print("[error]:: getting user role firestore -- \(failure.localizedDescription)")
                    completion(.failure(failure))
            }
        }
    }
    
}

