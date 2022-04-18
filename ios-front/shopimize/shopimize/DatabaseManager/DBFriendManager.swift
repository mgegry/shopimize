//
//  DBFriendManager.swift
//  shopimize
//
//  Created by Mircea Egry on 18/04/2022.
//

import Foundation
import FirebaseFirestoreSwift

class DBFriendManager {
    
    static let shared = DBFriendManager()
    
    private let friendCollection = FirebaseReferences.db.collection("Friend")
    private let friendRequestCollection = FirebaseReferences.db.collection("FriendRequest")
    
    private init() {}
    
    func getAllFirends(forUser email: String, completion: @escaping (Result<[String], Error>) -> ()) {
        
        var friends: [String] = []
        
        friendCollection.whereField("friendship", arrayContains: email).getDocuments { querySnapshot, error in
            guard let snapshot = querySnapshot, error == nil else {
                print("[error]:: getting all friends -- \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            
            for document in snapshot.documents {
                let result = Result {
                    try document.data(as: Friend.self)
                }
                
                switch result {
                    case .success(let success):
                        for user in success.friendship {
                            if user != email {
                                friends.append(user)
                            }
                        }
                    case .failure(let error):
                        print("[error]:: getting some of the friendships -- \(error.localizedDescription)")
                }
            }
            completion(.success(friends))
        }
    }
}
