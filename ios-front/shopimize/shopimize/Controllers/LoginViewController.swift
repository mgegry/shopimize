//
//  LoginViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import UIKit
import FirebaseAuth

/// Controller for the login view of the app
class LoginViewController: UIViewController {

    var loginView = LoginView()
    
    /// Load the view
    override func loadView() {
        view = loginView
        view.backgroundColor = .white
    }
    
    /// Do any aditional setup after the view was loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    /// Called when the login button is pressed
    @objc func didTapLogin() {
        FBAuthManager.shared.loginUserFirebase(withEmail: loginView.emailTextField.text ?? " ", password: loginView.passwordTextField.text ?? " ") { [weak self] result in
            
            if result == false {
                print("Login failed")
                return
            }
                    
            DispatchQueue.main.async {
                self?.dismiss(animated: true, completion: nil)
            }
            print("Login sucess")
        }
    }
}
