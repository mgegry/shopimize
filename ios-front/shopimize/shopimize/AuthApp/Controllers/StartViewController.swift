//
//  StartViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import UIKit
import FirebaseAuth

/// Controller for the first screen of the app
class StartViewController: UIViewController {

    var startView = StartView()
    var handle: AuthStateDidChangeListenerHandle?
    
    /// Setup the view
    override func loadView() {
        view = startView
        view.backgroundColor = .backgroundGrey
        
        startView.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        startView.registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    /// Do any aditional setup after the view was loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Shopimize"
        
    }
    
    /// Do any aditional setup before the view is about to appear
    ///
    /// - parameter animated: States if the view will apear animated or not
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            
            guard user != nil else {
                return
            }
            
            self?.navigationController?.pushViewController(LoginViewController(), animated: false)
        }
        
    }
    
    /// Do any aditional setup after the view is about to disapear
    ///
    /// - parameter animated: States if the view will disapear animated or not
    override func viewWillDisappear(_ animated: Bool) {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        } else {
            print("[info]:: user state did change listener was not set")
        }
    }
    
    /// Called when the user taps login button
    @objc func didTapLogin() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    /// Called when the user taps the register button
    @objc func didTapRegister() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
}
