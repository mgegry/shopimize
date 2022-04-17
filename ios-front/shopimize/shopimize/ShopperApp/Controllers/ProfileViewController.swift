//
//  ProfileTableViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import UIKit
import FirebaseAuth

/// Controller for the profile screen of the app

class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addButtonTargets()
        
        profileView.username.text = "mirceaegry"
        profileView.coins.text = "100"
        profileView.email.text = "mircea.egry@yahoo.com"
        profileView.profileImage.image = UIImage(systemName: "person")
    }
    
    private func addButtonTargets() {
        profileView.realPurchasesButton.addTarget(self, action: #selector(didTapRealPurchases), for: .touchUpInside)
        profileView.coinsPurchasesButton.addTarget(self, action: #selector(didTapCoinsPurchases), for: .touchUpInside)
        profileView.signOutButton.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
    }
    
    @objc func didTapRealPurchases() {
        
    }
    
    @objc func didTapCoinsPurchases() {
        
    }
    
    @objc func didTapSignOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }

}
