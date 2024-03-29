//
//  DBFriendManager.swift
//  shopimize
//
//  Created by Mircea Egry on 18/04/2022.
//

import Foundation
import FirebaseFirestoreSwift

/// Singleton class handeling FIrebase Firestore communication related to the friends and friends requests collections
class DBFriendManager {
    
    static let shared = DBFriendManager()
    
    let friendCollection = FirebaseReferences.db.collection("Friend")
    private let friendRequestCollection = FirebaseReferences.db.collection("FriendRequest")
    
    private init() {}
    
    /// Get all firends for a user
    ///
    /// - parameter email: user id
    /// - parameter completion: Escaping closure taking an array of friends as a parameter when the request finishes
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
    
    /// Gets all friend requests for a user
    ///
    /// - parameter email: user id
    /// - parameter completion: Escaping closure taking an array of friend requests as a parameter when the request finishes
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
    
    /// Gets all the sent friend requests for a user
    ///
    /// - parameter email: user id
    /// - parameter completion: Escaping closure taking a result as a parameter when the request finishes
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
    
    /// Adds a friend request to the Firebase database
    ///
    /// - parameter request: the friend request object to be added
    /// - parameter completion: Escaping closure taking a bool as a parameter when the request finishes
    func addFriendRequest(request: FriendRequest, completion: @escaping (Bool) -> ()) {
        do {
            let _ = try friendRequestCollection.addDocument(from: request)
            completion(true)
        } catch let error {
            print("[error]:: adding friend request -- \(error.localizedDescription)")
            completion(false)
        }
    }
    
    /// Add friend to database
    ///
    /// - parameter friend: the firend object to be added
    /// - parameter completion: Escaping closure taking a bool as a parameter when the request finishes
    func addFriend(friend: Friend, completion: @escaping (Bool) -> ()) {
        do {
            let _ = try friendCollection.addDocument(from: friend)
            completion(true)
        } catch let error {
            print("[error]:: adding friend -- \(error.localizedDescription)")
            completion(false)
        }
    }
    
    /// Deletes a friend request
    ///
    /// - parameter id: friend request id
    /// - parameter completion: Escaping closure taking a bool as a parameter when the request finishes
    func deleteFriendRequest(withId id: String, completion: @escaping (Bool) -> ()) {
        friendRequestCollection.document(id).delete { error in
            if let error = error {
                print("[error]:: deleting friend request -- \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
