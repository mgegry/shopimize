//
//  FriendViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 16/04/2022.
//

import UIKit

class FriendViewController: UIViewController {

    let friendView = FriendView()
    
    override func loadView() {
        view = friendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendView.profileImage.image = UIImage(systemName: "person")
        friendView.username.text = "mirciulica123"
        friendView.email.text = "mircea@eliade.com"
        friendView.shoppingStatus.text = "Currently shopping"
        // Do any additional setup after loading the view.
    }

}
