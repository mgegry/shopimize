//
//  LoginViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    var loginView = LoginView()
    
    override func loadView() {
        view = loginView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    @objc func didTapLogin() {
        FirebaseAuthManager.shared.loginUserFirebase(withEmail: loginView.emailTextField.text ?? " ", password: loginView.passwordTextField.text ?? " ") { [weak self] result in
            
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
