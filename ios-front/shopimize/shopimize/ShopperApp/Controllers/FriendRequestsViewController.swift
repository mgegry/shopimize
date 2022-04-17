//
//  FriendRequestsViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 16/04/2022.
//

import UIKit

class FriendRequestsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGrey
        
        setupNavigation()
        
    }
    
    private func setupNavigation() {
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        
        navigationItem.rightBarButtonItem = closeButton
        navigationItem.title = "Friend requests"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func didTapClose() {
        self.dismiss(animated: true, completion: nil)
    }

}
