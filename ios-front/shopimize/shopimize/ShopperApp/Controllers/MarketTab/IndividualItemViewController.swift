//
//  IndividualItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 03/05/2022.
//

import UIKit

class IndividualItemViewController: UIViewController {

    let individualItemView = IndividualItemView()
    var item: Item?
    
    override func loadView() {
        view = individualItemView
        view.backgroundColor = .backgroundGrey
        navigationItem.title = item?.itemName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        individualItemView.name.text = item?.itemName
        individualItemView.itemDescription.text = item?.description
        individualItemView.coins.text = "£ " + String(item?.price ?? 0)
        individualItemView.image.image = item?.image
        
        // Do any additional setup after loading the view.
    }

}
