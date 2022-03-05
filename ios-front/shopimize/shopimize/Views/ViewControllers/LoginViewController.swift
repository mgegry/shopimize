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
        print("I want to login: \(loginView.emailTextField.text ?? "fuata") ")
    }
}
