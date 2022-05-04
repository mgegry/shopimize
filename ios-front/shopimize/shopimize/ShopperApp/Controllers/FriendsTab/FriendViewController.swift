//
//  FriendViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 16/04/2022.
//

import UIKit

class FriendViewController: UIViewController {

    let friendView = FriendView()
    var user: User?
    
    override func loadView() {
        view = friendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = user?.username
        
        friendView.username.text = user?.username
        friendView.shoppingStatus.text = "Currently Shopping"
        friendView.image.image = user?.image
        friendView.email.text = user?.id
    }

}
