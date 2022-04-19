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
}
