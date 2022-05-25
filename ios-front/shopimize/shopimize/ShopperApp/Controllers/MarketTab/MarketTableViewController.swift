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
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "getMarketQueue")
        
        var marketsRequest: [Market] = []
        
        guard markets.isEmpty else { return }
        
        group.enter()
        queue.async {
            DBMarketManager.shared.getAllActiveMarketsFirestore { result in
                
                switch result {
                case .success(let data):
                    marketsRequest = data

                case .failure(_):
                    print("fauta fuata")
                }
                group.leave()
            }
        }
        
        queue.async {
            group.wait()
            for i in marketsRequest.indices {
                group.enter()
                DBStoreManager.shared.getStoreForId(store_id: marketsRequest[i].storeID) { result in
                    guard let store = result else {
                        return
                    }
                    marketsRequest[i].storeName = store.name
                    marketsRequest[i].imageUrl = store.imageUrl
                    group.leave()
                }
            }
            group.notify(queue: .main) { [weak self] in
                self?.markets = marketsRequest
                self?.tableView.reloadData()
            }
        }
        
        queue.async {
            group.wait()
            for i in marketsRequest.indices {
                
                if let url = marketsRequest[i].imageUrl {
                    group.enter()
                    StorageManager.shared.fetchImage(from: URL(string: url)!) { data in
                        guard let imageData = data else {
                            // PRINT ERROR
                            return
                        }
                        
                        marketsRequest[i].image = UIImage(data: imageData)!
                        group.leave()
                    }
                }
            }
            
            group.notify(queue: .main) { [weak self] in
                self?.markets = marketsRequest
                self?.tableView.reloadData()
            }
        }
        
        
    }
    
    /// Do any aditional setup after the view loaded
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavbar()
    }
    
    private func setupViews() {
        view.backgroundColor = .backgroundGrey
        
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: "marketCell")
        tableView.separatorStyle = .none
    }
    
    /// Setup the layout and design of the navigation bar
    ///
    private func setupNavbar() {
        guard let nav = navigationController else { return }
        
        let boundsWidth = nav.navigationBar.bounds.width - NavigationConstants.navigationInset
        let boundsHeight = nav.navigationBar.bounds.height
        
        
        let titleView = HomeNavigation(frame: CGRect(x: 0, y: 0, width: boundsWidth, height: boundsHeight))
        
        titleView.cartButton.addTarget(self, action: #selector(didTapCart), for: .touchUpInside)
        titleView.filterButton.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        
        self.navigationItem.titleView = titleView
    }
    
    @objc func didTapFilter() {
        let vc = UINavigationController(rootViewController: MarketFilterViewController())
        present(vc, animated: true, completion: nil)
    }
    
    @objc func didTapCart() {
        navigationController?.pushViewController(CartViewController(), animated: true)
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
        
        let obj = markets[indexPath.row]
        
        if let storeName = markets[indexPath.row].storeName {
            cell.nameLabel.text = storeName
        }
        cell.locationLabel.text = "\(obj.street), \(obj.city), \(obj.postalCode)"
        if let image = markets[indexPath.row].image {
            cell.image.image = image
        }
        
//        let date = markets[indexPath.row].createdAt.dateValue()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy--MM--dd HH:mm:ss ZZZ"
//        let formattedTime = formatter.string(from: date)

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
    
    /// Method called when one of the table cells is selected
    ///
    /// - parameter tableView: The current table
    /// - parameter indexPath: The index of the current row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let marketID = markets[indexPath.row].id else {
            return
        }
        
        let itemController = ItemViewController()
        
        itemController.marketID = marketID
        navigationController?.pushViewController(itemController, animated: true)
    }
}
