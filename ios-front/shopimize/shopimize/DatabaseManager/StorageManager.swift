//
//  StorageManager.swift
//  shopimize
//
//  Created by Mircea Egry on 19/03/2022.
//

import Foundation
import FirebaseStorage
import UIKit


/// Singleton class that handles all communication with Firebase Storage
class StorageManager {
    
    static let shared = StorageManager()
    
    private init() { }
    
    /// Adds image to firebase storage
    ///
    /// - parameter image: the image to be added
    /// - parameter toPath: path to which the image should be added
    /// - parameter completion: Escaping closure taking a bool as a parameter when the request finishes
    func addImageToFirebaseStorage(_ image: UIImage, toPath path: String, completion: @escaping (Bool) -> ()) {
        let storageRef = FirebaseReferences.storage.reference().child(path)
        
        guard let data = image.pngData() else {
            completion(false)
            return
        }
        
        storageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                print("[error]:: adding image to Firebase Storage -- \(error!.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    /// Gets the download url for a given item picture
    ///
    /// - parameter picture_id: item picture id
    /// - parameter completion: Escaping closure taking a result as a parameter when the request finishes
    func getItemPictureURL(picture_id: String,  completion: @escaping (Result<URL, Error>) -> ()) {
        let path = "item_images/" + picture_id + "/itemImage.png"
        let storageRef = FirebaseReferences.storage.reference().child(path)
        
        storageRef.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(url))
        }
    }
    
    /// Gets picture URL for  store
    ///
    /// - parameter picture_id: friend request id
    /// - parameter completion: Escaping closure taking a result as a parameter when the request finishes
    func getStorePictureURL(picture_id: String, completion: @escaping (Result<URL, Error>) -> ()) {
        let path = "store_images/" + picture_id + "/storeImage.png"
        let storageRef = FirebaseReferences.storage.reference().child(path)
        
        storageRef.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(url))
        }
    }
    
    /// Gets user profile picture URL
    ///
    /// - parameter email: user email
    /// - parameter completion: Escaping closure taking a result as a parameter when the request finishes
    func getUserProfilePicture(withEmail email: String, completion: @escaping (Result<URL, Error>) -> ()) {
        let path = "images/" + email + "/profileImage.png"
        let storageRef = FirebaseReferences.storage.reference().child(path)
        
        storageRef.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(url))
        }
    }
    
    /// Fetch an image for the given URL
    ///
    /// - parameter url: the url from where to download the image
    /// - parameter completion: Escaping closure taking optional image data as a parameter when the request finishes
    func fetchImage(from url: URL, completionHandler: @escaping (Data?) -> ()) {
        let session = URLSession.shared
            
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("[error]:: getting image -- \(error!.localizedDescription)")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
            
        dataTask.resume()
    }
}
