//
//  AddFriendViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 16/04/2022.
//

import UIKit

class AddFriendViewController: UIViewController {

    let addFriendView = AddFriendView()
    
    override func loadView() {
        view = addFriendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setupNavigation() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = cancelButton
        navigationItem.title = "Add friend"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
