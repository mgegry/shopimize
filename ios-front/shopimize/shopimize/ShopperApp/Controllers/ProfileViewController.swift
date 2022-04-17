//
//  ProfileTableViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import UIKit

/// Controller for the profile screen of the app

class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        profileView.username.text = "mirceaegry"
        profileView.coins.text = "100"
        profileView.email.text = "mircea.egry@yahoo.com"
        profileView.profileImage.image = UIImage(systemName: "person")
    }

}
