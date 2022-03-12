//
//  ProfileTableViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import UIKit

/// Controller for the profile screen of the app

class ProfileTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "profileCell")
        tableView.separatorStyle = .none
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as? ProfileTableViewCell else {
            fatalError("Can not dequeue cell with identifier profileCell")
        }

        cell.testLabel.text = String(indexPath.row)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableConstants.cellHeight)
    }

}
