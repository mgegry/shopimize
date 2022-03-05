//
//  StartViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import UIKit

class StartViewController: UIViewController {

    var startView = StartView()
    
    override func loadView() {
        view = startView
        view.backgroundColor = .white
        
        startView.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        startView.registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Shopimize"
        
    }
    
    @objc func didTapLogin() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func didTapRegister() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
}
