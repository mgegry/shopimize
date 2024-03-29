//
//  AddFriendViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 16/04/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AddFriendViewController: UIViewController {

    let addFriendView = AddFriendView()
    
    override func loadView() {
        view = addFriendView
        addFriendView.addFriendButton.addTarget(self, action: #selector(didTapAddFriend), for: .touchUpInside)
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
    
    @objc func didTapAddFriend() {
        print("futa")
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "addFriendQueue")
        
        var failure = false
        
        guard let userEmail = Auth.auth().currentUser?.email else { return }
        guard let addedUser = addFriendView.username.text, addFriendView.username.text != "" else {
            
            return
        }
        
        group.enter()
        queue.async {
            DBFriendManager.shared.getAllFriendRequests(forUser: userEmail) { result in
                switch result {
                    case .success(let success):
                        for request in success {
                            if request.fromUser == addedUser {
                                failure = true
                                DispatchQueue.main.async { [weak self] in
                                    self?.presentAlert(withMessage: "It looks like you have a friend request from this user")
                                }
                            }
                        }
                    case .failure(_):
                        failure = true
                        print("uata")
                }
                group.leave()
            }
        }
        
        queue.async {
            group.wait()
            group.enter()
            DBFriendManager.shared.getAllSentFriendRequests(forUser: userEmail) { result in
                switch result {
                    case .success(let success):
                        for request in success {
                            if request.toUser == addedUser {
                                failure = true
                                DispatchQueue.main.async { [weak self] in
                                    self?.presentAlert(withMessage: "You already sent a friend request to this user")
                                }
                            }
                        }
                    case .failure(_):
                        failure = true
                        print("uata")
                }
                group.leave()
            }
        }
        
        queue.async {
            group.wait()
            if (!failure) {
                group.enter()
                let request = FriendRequest(fromUser: userEmail, toUser: addedUser, createdAt: Timestamp(date: Date.now))
                DBFriendManager.shared.addFriendRequest(request: request) { result in
                    if !result {
                        DispatchQueue.main.async { [weak self] in
                            self?.presentAlert(withMessage: "Can not send friend request at this moment")
                        }
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            self?.dismiss(animated: true, completion: nil)
                        }
                    }
                    group.leave()
                }
            }
        }
    }
    
    @objc func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func presentAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Error adding user",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
