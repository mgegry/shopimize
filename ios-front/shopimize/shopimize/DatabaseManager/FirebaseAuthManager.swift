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
    
    private init() { }
    
    func createUserFirebase(withEmail email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(false)
                print("[error]:: firebase create account -- \(error.localizedDescription)")
                return
            }
            completion(true)
        }
    }
    
    func loginUserFirebase(withEmail email: String, password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { authData, error in
            if let error = error {
                completion(false)
                print("[error]:: firebase failed to login -- \(error.localizedDescription)")
                return
            }
            completion(true)
        }
    }
    
}
