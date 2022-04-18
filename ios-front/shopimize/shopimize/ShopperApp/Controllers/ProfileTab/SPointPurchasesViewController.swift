//
//  SPointPurchasesViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 18/04/2022.
//

import UIKit

class SPointPurchasesViewController: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGrey
        
        setupNavigation()
        setupTable()
        setupConstraints()
    }
    
    private func setupTable() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .backgroundGrey
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: "cartCell")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        navigationItem.title = "Purchase history"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

}

extension SPointPurchasesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? CartTableViewCell else {
            fatalError("Can not dequeue cell with identifier friendsCell")
        }
        
        cell.userLabel.text = "item 1"

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableConstants.friendsCellHeight)
    }
}
