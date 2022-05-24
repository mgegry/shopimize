//
//  IndividualItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 03/05/2022.
//

import UIKit
import FirebaseAuth

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
        setupItemInformation()
        setupButtonTargets()
    }
    
    private func setupItemInformation() {
        individualItemView.name.text = item?.itemName
        individualItemView.itemDescription.text = item?.description
        individualItemView.coins.text = "£ " + String(item?.price ?? 0)
        individualItemView.image.image = item?.image
    }
    
    private func setupButtonTargets() {
        individualItemView.addToCartButton.addTarget(self, action: #selector(didTapAddToCart), for: .touchUpInside)
    }
    
    @objc func didTapAddToCart() {
        guard let userEmail = Auth.auth().currentUser?.email,
              let itemId = item?.id
        else { return }
        
        DBUserManager.shared.addItemToUserCart(user: userEmail, item: itemId) { [weak self] result in
            switch result {
                case true:
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                case false:
                    let alert = UIAlertController(title: "Cart unavailable",
                                                  message: "Uable to add item to cart",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                    
                    DispatchQueue.main.async {
                        self?.present(alert, animated: true)
                    }
            }
        }
    }
    
}
