//
//  CartViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 16/03/2022.
//

import UIKit

/// Controller for the shopping cart screen of the app

class CartViewController: UIViewController {

    let cartView = CartView()
    
    override func loadView() {
        view = cartView
    }
    
    /// Do any aditional setup after the view loaded
    ///
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
