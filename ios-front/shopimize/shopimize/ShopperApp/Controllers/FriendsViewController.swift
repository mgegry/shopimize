//
//  FriendsViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 16/04/2022.
//

import UIKit

class FriendsViewController: UIViewController {
    
    var tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        view.backgroundColor = .backgroundGrey
        
        setupTableView()
        setupConstraints()
        setupNavbar()
    }
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        tableView.backgroundColor = .backgroundGrey
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: "friendsCell")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavbar() {
        guard let nav = navigationController else { return }
        
        let boundsWidth = nav.navigationBar.bounds.width - 15
        let boundsHeight = nav.navigationBar.bounds.height
        
        
        let titleView = FriendsNavigation(frame: CGRect(x: 0, y: 0, width: boundsWidth, height: boundsHeight))
        self.navigationItem.titleView = titleView
    }

}

// MARK: Extensions

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as? FriendsTableViewCell else {
            fatalError("Can not dequeue cell with identifier friendsCell")
        }

        cell.testLabel.text = String(indexPath.row)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableConstants.cellHeight)
    }
    
}
