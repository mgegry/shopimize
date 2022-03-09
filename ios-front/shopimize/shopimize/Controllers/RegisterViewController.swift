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
        
        FirebaseAuthManager.shared.createUserFirebase(withEmail: email, password: password) { [weak self] result in
            if result == false {
                print("Account not created")
                return
            }
            
            
            
            print("Account was created")
            
            DispatchQueue.main.async {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
