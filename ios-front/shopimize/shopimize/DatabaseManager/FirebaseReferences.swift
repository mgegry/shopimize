//
//  FirebaseReferences.swift
//  shopimize
//
//  Created by Mircea Egry on 12/03/2022.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

/// Struct containing connection objects to firebase services

struct FirebaseReferences {
    
    /// Firebase Authentication object
    static let auth = Auth.auth()
    
    /// Firebase Firestore database oject
    static let db = Firestore.firestore()
}
