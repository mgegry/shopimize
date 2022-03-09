//
//  MarketTableViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 06/03/2022.
//

import UIKit

class MarketTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: "marketCell")
        tableView.separatorStyle = .singleLine
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell",for: indexPath) as? MarketTableViewCell else {
            fatalError("Can not dequeue market table view cell with identifier")
        }

         

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableConstants.cellHeight)
    }
}
