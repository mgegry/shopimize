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
        
        // TODO: Handle form validation better
        
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
                // TODO: Display information to user not just to console
                print("Account not created")
                return
            }
            
            
            // TODO: Display information to user with alerts
            print("Account was created")
            
            DispatchQueue.main.async {
                self?.dismiss(animated: true, completion: nil)
            }
        }
        
        let user = User(firstName: registerView.firstNameTextField.text ?? "123", lastName: registerView.lastNameTextField.text ?? "234")
        
        DBManager.shared.addUserFirestore(with: email, user: user) { result in
            guard result == true else {
                // TODO: Display infromation to the user
                print("User was not saved to firestore DB")
                return
            }
            
            print("User was saved to firebase DB")
        }
    }
}
