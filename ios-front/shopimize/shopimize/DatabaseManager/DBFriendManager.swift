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
    
    func getAllFriends(forUser email: String, completion: @escaping (Result<[Friend], Error>) -> ()) {
        
        var friends: [Friend] = []
        
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
                        friends.append(success)
                    case .failure(let error):
                        print("[error]:: getting some of the friendships -- \(error.localizedDescription)")
                }
            }
            completion(.success(friends))
        }
    }
    
    func getAllFriendRequests(forUser email: String, completion: @escaping (Result<[FriendRequest], Error>) -> ()) {
        var friendRequests: [FriendRequest] = []
        
        friendRequestCollection.whereField("to_user", isEqualTo: email).getDocuments { querySnapshot, error in
            guard let snapshot = querySnapshot, error == nil else {
                print("[error]:: getting all friends -- \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            
            for document in snapshot.documents {
                let result = Result {
                    try document.data(as: FriendRequest.self)
                }
                
                switch result {
                    case .success(let success):
                        friendRequests.append(success)
                    case .failure(let error):
                        print("[error]:: getting some of the requests -- \(error.localizedDescription)")
                }
            }
            completion(.success(friendRequests))
        }
    }
    
    func getAllSentFriendRequests(forUser email: String, completion: @escaping (Result<[FriendRequest], Error>) -> ()) {
        var friendRequests: [FriendRequest] = []
        
        friendRequestCollection.whereField("from_user", isEqualTo: email).getDocuments { querySnapshot, error in
            guard let snapshot = querySnapshot, error == nil else {
                print("[error]:: getting all friends -- \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            
            for document in snapshot.documents {
                let result = Result {
                    try document.data(as: FriendRequest.self)
                }
                
                switch result {
                    case .success(let success):
                        friendRequests.append(success)
                    case .failure(let error):
                        print("[error]:: getting some of the requests -- \(error.localizedDescription)")
                }
            }
            completion(.success(friendRequests))
        }
    }
}
