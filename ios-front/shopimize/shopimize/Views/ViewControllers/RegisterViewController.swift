//
//  RegisterViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    var registerView = RegisterView()
    
    override func loadView() {
        view = registerView
        view.backgroundColor = .white
        
        registerView.registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @objc func didTapRegister() {
        
        guard let email = registerView.emailTextField.text else {
            print("email pass fuata")
            return
        }
        
        guard let password = registerView.passwordTextField.text else {
            print("")
            return
        }
        
        if password == "" || email == "" {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("An error occured \(error.localizedDescription)")
            } else {
                
                print(authResult?.user.email ?? "")
            }
        }
    }
    
    
    
    
}
