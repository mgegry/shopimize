//
//  DBStoreManager.swift
//  shopimize
//
//  Created by Mircea Egry on 24/03/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


/// Singleton class handeling FIrebase Firestore communication related to the store collection
class DBStoreManager {
    
    static let shared = DBStoreManager()
    
    private var storeCollection = FirebaseReferences.db.collection("Store")
    
    private init() { }
    
    /// Get all sotres from database
    ///
    /// - parameter completion: Escaping closure taking a result as a parameter when the request finishes
    func getAllStores(completion: @escaping (Result<[Store], Error>) -> ()) {
        var stores: [Store] = []
        
        storeCollection.getDocuments { querySnapshot, error in
            guard let snapshot = querySnapshot, error == nil else {
                print("[error]:: getting all stores firebase -- \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            
            for document in snapshot.documents {
                let result = Result {
                    try document.data(as: Store.self)
                }
                
                switch result {
                    case .success(let success):
                        stores.append(success)
                    case .failure(let failure):
                        print("[error]:: getting specific store firebase -- \(failure.localizedDescription)")
                }
            }
            completion(.success(stores))
        }
    }
    
    /// Adds store to Firebase database
    ///
    /// - parameter store: the store object to be added
    /// - parameter completion: Escaping closure taking a bool as a parameter when the request finishes
    func addStoreToFirebase(store: Store, completion: @escaping (Bool) -> ()) {
        do {
            let _ = try storeCollection.addDocument(from: store)
            completion(true)
        } catch let error {
            print("[error]:: adding store to firebase -- \(error.localizedDescription)")
            completion(false)
        }
    }
    
    /// Gets the store for a given id
    ///
    /// - parameter store: the store id
    /// - parameter completion: Escaping closure taking an optional store as a parameter when the request finishes
    func getStoreForId(store_id: String, completion: @escaping (Store?) -> ()) {
        storeCollection.document(store_id).getDocument(as: Store.self, completion: { result in
            switch result {
                case .success(let success):
                    completion(success)
                case .failure(let failure):
                    print("[error]:: getting user firestore -- \(failure.localizedDescription)")
                    completion(nil)
            }
            
        })
    }
    
}
