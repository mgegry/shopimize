//
//  FirebaseAuthManager.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import Foundation
import FirebaseAuth

/// Singleton class that handles Firebase Authentication

class FBAuthManager {
    
    static let shared = FBAuthManager()
    
    private init() { }
    
    /// Adds a new user to Firebase Authentication system
    ///
    ///  - parameter email: The email of the user
    ///  - parameter password: The password of the user
    ///  - parameter completion: Escaping closure to be called when operation finishes
    func createUserFirebase(withEmail email: String, password: String, completion: @escaping (Error?) -> ()) {
        
        FirebaseReferences.auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
                print("[error]:: firebase create account -- \(error.localizedDescription)")
                return
            }
            completion(nil)
        }
    }
    
    /// Logins the provided user to Firebase Authentication
    ///
    /// - parameter email: The email of the user
    /// - parameter password: The password of the user
    /// - parameter closure: Escaping closure to be called when operation finishes
    func loginUserFirebase(withEmail email: String, password: String, completion: @escaping (Result<String, Error>) -> ()) {
        FirebaseReferences.auth.signIn(withEmail: email, password: password) { authData, error in
            
            guard let email = authData?.user.email, error == nil else {
                completion(.failure(error!))
                print("[error]:: firebase failed to login -- \(error!.localizedDescription)")
                return
            }
            
            completion(.success(email))
        }
    }
    
}
