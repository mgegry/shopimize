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
    
    /// Add user to Firebase Firestore after sign up
    ///
    /// - parameter email: The user email
    /// - parameter user: An user object containing user information
    /// - parameter completion: Escaping closure receiving operation result as boolean
    func addUserFirestore(withEmail email: String, user: User, completion: @escaping (Bool) -> ()) {
        do {
            try userCollection.document(email).setData(from: user)
            completion(true)
        } catch let error {
            print("Error wirting user to Firestore: \(error.localizedDescription)")
            completion(false)
        }
    }
    
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
    
    /// Check that the given username is unique in the Firebase database
    ///
    /// - parameter username: The username to be checked
    /// - parameter completion: Escaping closure taking a bool as a parameter
    func checkUsernameUnique(username: String, completion: @escaping (Bool) -> ()) {
        userCollection.whereField("username", isEqualTo: username).getDocuments { querySnapshot, error in
            guard let snapshot = querySnapshot, error ==  nil else {
                print("[error]:: check user unique -- \(error!.localizedDescription)")
                completion(false)
                return
            }
            
            if snapshot.documents.count == 0 {
                completion(true)
            }
            
            completion(false)
        }
    }
    
    /// Save profile image for user to its Firestore document
    ///
    /// - parameter email: User email
    /// - parameter toPath: Path to the image
    /// - parameter completion: Escaping closure taking a bool as a parameter when the request finishes
    func saveProfileImageForUser(withEmail email: String, toPath path: String, completion: @escaping (Bool) -> ()) {
        userCollection.document(email).updateData(["image_url": path]) { error in
            if let err = error {
                print("[error]:: saving profile image path to firestore -- \(err.localizedDescription)")
                completion(false)
            }
            completion(true)
        }
    }
    
    /// Adds item to the user's cart
    ///
    /// - parameter user: user id
    /// - parameter completion: Escaping closure taking a bool as a parameter when the request finishes
    public func addItemToUserCart(user: String, item: String, completion: @escaping (Bool) -> ()) {
        userCollection.document(user).updateData(["items" : FieldValue.arrayUnion([item])]) { error in
            guard error == nil else {
                print("[error]:: adding item to cart -- \(error!.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
}

