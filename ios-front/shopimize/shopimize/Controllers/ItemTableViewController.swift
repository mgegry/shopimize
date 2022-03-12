//
//  ItemTableViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 11/03/2022.
//

import UIKit

/// Controller for the item table view screen of the app

class ItemTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else {
            fatalError("Unable to deque cell with identifier itemCell.")
        }
        
        cell.itemName.text = "fuata"
        
        return cell
    }
    
}
