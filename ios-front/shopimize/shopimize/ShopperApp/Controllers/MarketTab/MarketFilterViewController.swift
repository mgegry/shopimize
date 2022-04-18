//
//  MarketFilterViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 18/04/2022.
//

import UIKit

class MarketFilterViewController: UIViewController {

    let marketFilterView = MarketFilterView()
    
    override func loadView() {
        view = marketFilterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setupNavigation() {
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapCancel))
        
        navigationItem.title = "Add filters"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = cancelButton
    }

    @objc func didTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
