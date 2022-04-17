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
        
        if let user = Auth.auth().currentUser {
            DBUserManager.shared.getUserFirestore(withEmail: user.email!) { [weak self] result in
                guard let strongSelf = self else { return }
                
                switch result {
                    case .success(let user):
                        DispatchQueue.main.async {
                            strongSelf.profileView.username.text = user.username
                            strongSelf.profileView.coins.text = "\(user.points ?? 0)"
                            strongSelf.profileView.email.text = user.id
                        }
                    case .failure(_):
                        print("Error getting user information")
                }
            }
        }
       
        setupNavbar()
        addButtonTargets()
        
        
        profileView.profileImage.image = UIImage(systemName: "person")
    }
    
    private func addButtonTargets() {
        profileView.realPurchasesButton.addTarget(self, action: #selector(didTapRealPurchases), for: .touchUpInside)
        profileView.coinsPurchasesButton.addTarget(self, action: #selector(didTapCoinsPurchases), for: .touchUpInside)
        profileView.signOutButton.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
    }
    
    private func setupNavbar() {
        guard let nav = navigationController else { return }
        
        let boundsWidth = nav.navigationBar.bounds.width - NavigationConstants.navigationInset
        let boundsHeight = nav.navigationBar.bounds.height
        
        
        let titleView = ProfileNavigation(frame: CGRect(x: 0, y: 0, width: boundsWidth, height: boundsHeight))
        self.navigationItem.titleView = titleView
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
