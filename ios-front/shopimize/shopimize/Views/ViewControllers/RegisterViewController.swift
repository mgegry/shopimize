//
//  RegisterViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import UIKit

class RegisterViewController: UIViewController {

    var registerView = RegisterView()
    
    override func loadView() {
        view = registerView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
}
