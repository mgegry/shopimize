//
//  StorageManager.swift
//  shopimize
//
//  Created by Mircea Egry on 19/03/2022.
//

import Foundation
import FirebaseStorage
import UIKit

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() { }
    
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
