//
//  FirebaseAuthManager.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    
    let fbAuth = Auth.auth()
    
    private init() { }
    
    func createUserFirebase(withEmail email: String, password: String, completion: @escaping (Bool) -> ()) {
        
        fbAuth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false)
                print("[error]:: firebase create account -- \(error.localizedDescription)")
                return
            }
            completion(true)
        }
    }
    
    func loginUserFirebase(withEmail email: String, password: String, completion: @escaping (Bool) -> ()) {
        fbAuth.signIn(withEmail: email, password: password) { authData, error in
            if let error = error {
                completion(false)
                print("[error]:: firebase failed to login -- \(error.localizedDescription)")
                return
            }
            completion(true)
        }
    }
    
}
