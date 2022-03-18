//
//  MarketTableViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 06/03/2022.
//

import UIKit
import FirebaseFirestoreSwift
import FirebaseFirestore

/// Controller for the market table view screen

class MarketTableViewController: UITableViewController {
    
    /// Holds all markets information
    var markets: [Market] = []
    
    /// Do any aditional setup before the view is about to appear
    ///
    /// - parameter animated: States if the view will appear animated or not
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DBMarketManager.shared.getAllActiveMarketsFirestore { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    strongSelf.markets = data
                    strongSelf.tableView.reloadData()
                }
                
            case .failure(_):
                print("fauta fuata")
            }
        }
    }
    
    /// Do any aditional setup after the view loaded
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundGrey
        
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: "marketCell")
        tableView.separatorStyle = .none
        
        setupNavbar()
    }
    
    /// Return the number of section in the table
    ///
    /// - parameter tableView: The current table
    /// - returns: number of sections in table
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    /// Return the number of rows in a section
    ///
    /// - parameter tableView: The current table
    /// - parameter section: The current section
    /// - returns: number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return markets.count
    }

    /// Set the contents of a  cell at a given index
    ///
    /// - parameter tableView: The current table
    /// - parameter indexPath: The current index of the row
    /// - returns: the cell containing the market data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell",for: indexPath) as? MarketTableViewCell else {
            fatalError("Can not dequeue market table view cell with identifier")
        }
        
        cell.shopName.text = markets[indexPath.row].shopName
        
        let date = markets[indexPath.row].createdAt.dateValue()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy--MM--dd HH:mm:ss ZZZ"
        let formattedTime = formatter.string(from: date)
        
        cell.createdAt.text = formattedTime

        return cell
    }
    
    /// Set the cell height
    ///
    /// - parameter tableView: The current table
    /// - parameter indexPath: The index of the current row
    /// - returns: The height of for the current cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableConstants.cellHeight)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let marketID = markets[indexPath.row].id else {
            return
        }
        
        let itemController = ItemViewController()
        
        itemController.marketID = marketID
        navigationController?.pushViewController(itemController, animated: true)
    }
    
    /// Setup the layout and design of the navigation bar
    ///
    private func setupNavbar() {
        guard let nav = navigationController else { return }
        
        let boundsWidth = nav.navigationBar.bounds.width - 15
        let boundsHeight = nav.navigationBar.bounds.height
        
        
        let titleView = HomeNavigation(frame: CGRect(x: 0, y: 0, width: boundsWidth, height: boundsHeight))
        self.navigationItem.titleView = titleView
    }
}
