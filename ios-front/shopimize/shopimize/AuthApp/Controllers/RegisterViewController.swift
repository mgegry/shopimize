//
//  RegisterViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

/// Controller for the register screen of the app

class RegisterViewController: UIViewController {

    var registerView = RegisterView()
    
    /// Load the view
    override func loadView() {
        view = registerView
        view.backgroundColor = .white
        setupNavigation()
        registerView.registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    private func setupNavigation() {
        navigationItem.title = "Register"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    /// Do any aditional setup after the view was loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: UIResponder.keyboardDidChangeFrameNotification,
                                       object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            registerView.scrollView.contentInset = .zero
        } else {
            registerView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                               bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        registerView.scrollView.scrollIndicatorInsets = registerView.scrollView.contentInset

    }
    
    private func presentAlert(withTitle title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Called when the user taps register button on the register screen
    @objc func didTapRegister() {
        
        guard let username = registerView.username.text, username != "",
              let email = registerView.email.text, email != "",
              let password = registerView.password.text, password != "",
              let confirmPassword = registerView.confirmPassword.text, confirmPassword != "" else {
                  presentAlert(withTitle: "Register error",
                               message: "Please check that all fields are filled in",
                               actions: [UIAlertAction(title: "Cancel", style: .cancel, handler: nil)])
                  return
              }
        
        let u = username.filter { !$0.isWhitespace }
        let e = email.filter { !$0.isWhitespace }
        let p = password.filter { !$0.isWhitespace }
        let cp = confirmPassword.filter { !$0.isWhitespace }
        
        if p != cp {
            presentAlert(withTitle: "Register error",
                         message: "Passwords do not match",
                         actions: [UIAlertAction(title: "Cancel", style: .cancel, handler: nil)])
        }
        
        DBUserManager.shared.checkUsernameUnique(username: u) { [weak self] result in
            guard let strongSelf = self else { return }
            
            guard result == true else {
                DispatchQueue.main.async {
                    strongSelf.presentAlert(withTitle: "Register error",
                                            message: "Username already in use",
                                            actions: [UIAlertAction(title: "Cancel", style: .cancel, handler: nil)])
                }
                return
            }
        }
            
        FBAuthManager.shared.createUserFirebase(withEmail: e, password: p) { [weak self] error in
            guard let strongSelf = self else { return }
            
            guard error != nil else {
                DispatchQueue.main.async {
                    strongSelf.presentAlert(withTitle: "Register error",
                                            message: "Please check provided information",
                                            actions: [UIAlertAction(title: "Cancel", style: .cancel, handler: nil)])
                }
                return
            }
            
            let user = User(username: u, points: 0, role: "shopper", createdAt: Timestamp(date: Date.now), isActive: true)
            
            DBUserManager.shared.addUserFirestore(withEmail: e, user: user) { result in
                guard result == true else {
                    DispatchQueue.main.async {
                        strongSelf.presentAlert(withTitle: "Creating user error",
                                                message: "Please try again later",
                                                actions: [UIAlertAction(title: "Cancel", style: .cancel, handler: nil)])
                    }
                    return
                }
            }
            
        }
    }
    
}
