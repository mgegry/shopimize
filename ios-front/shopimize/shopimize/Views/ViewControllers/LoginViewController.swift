//
//  LoginViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import UIKit

class LoginViewController: UIViewController {

    var loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .red
        loginView.testButton.addTarget(self, action: #selector(testButtonTap), for: .touchUpInside)
    }
    
    @objc func testButtonTap() {
        loginView.testButton.setTitle("haha", for: .normal)
        print("fuata")
    }

}
