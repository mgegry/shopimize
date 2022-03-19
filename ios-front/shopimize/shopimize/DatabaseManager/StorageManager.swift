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
}
