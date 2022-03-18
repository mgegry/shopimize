//
//  MAddItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 18/03/2022.
//

import UIKit

class MAddItemViewController: UIViewController {

    /// price date-added is-active photo name description markets shop
    
    let addItemView = AddItemView()
    
    override func loadView() {
        view = addItemView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
}
