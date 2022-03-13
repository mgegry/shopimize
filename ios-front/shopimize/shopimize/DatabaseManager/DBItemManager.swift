//
//  DBItemManager.swift
//  shopimize
//
//  Created by Mircea Egry on 12/03/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

/// Singleton class that handles the Firebase Firestore communication methonds related to the items

final class DBItemManager {
    
    static let shared = DBItemManager()
    
    /// Firebase firestore object related to Item collection
    private let itemCollection = FirebaseReferences.db.collection("Item")
    
    /// Private initializer since singleton class
    private init() { }
    
    /// Get all documents form firestore database item collection
    func getAllItemsFirestore(completion: @escaping (Result<[Item], Error>) -> ()) {
        var items: [Item] = []
        
        itemCollection.getDocuments { querySnapshot, error in
            guard let snapshot = querySnapshot, error == nil else {
                print("[error]:: getting all items from firestore -- \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            
            for document in snapshot.documents {
                let result = Result {
                    try document.data(as: Item.self)
                }
                
                switch result {
                case .success(let item):
                    items.append(item)
                case .failure(let error):
                    print("[error]:: Can not get document in item collection -- \(error.localizedDescription)")
                }
            }
            completion(.success(items))
        }
    }
}
