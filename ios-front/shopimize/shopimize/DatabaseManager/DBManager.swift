//
//  DBManager.swift
//  shopimize
//
//  Created by Mircea Egry on 09/03/2022.
//

import Firebase
import FirebaseFirestore
import FirebaseCore
import Foundation

class DBManager {
    static let shared = DBManager()
    
    private let db = Firestore.firestore()
    
    private init() { }
    
//    func addUserFirestore(with email: String, user: User, completion: @escaping (Bool) -> ()) {
//
//    }
    
}
