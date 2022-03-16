//
//  StartViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import UIKit

/// Controller for the first screen of the app
class StartViewController: UIViewController {

    var startView = StartView()
    
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
    
    /// Called when the user taps login button
    @objc func didTapLogin() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    /// Called when the user taps the register button
    @objc func didTapRegister() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
}
