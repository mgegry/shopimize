//
//  ItemTableViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 11/03/2022.
//

import UIKit

/// Controller for the item table view screen of the app

class ItemTableViewController: UITableViewController {

    /// Market for which to show items
    var marketID: String = ""
    
    /// Array of items for this market
    var items: [Item] = []
    
    /// Called when thew view is about to appear
    ///
    /// - parameter animated: States if the view will appear animated or not
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .backgroundGrey
        
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "itemCell")
        tableView.separatorStyle = .none
        
        DBItemManager.shared.getItemsForMarketFirestore(marketID: marketID) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let items):
                strongSelf.items = items
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
                
            case .failure(_):
                print("Failed at getting items")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else {
            fatalError("Unable to deque cell with identifier itemCell.")
        }
        
        cell.itemName.text = items[indexPath.row].itemName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableConstants.cellHeight)
    }
    
}
