//
//  MarketTableViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 06/03/2022.
//

import UIKit
import FirebaseFirestoreSwift
import FirebaseFirestore

class MarketTableViewController: UITableViewController {
    
    var markets: [Market] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DBManager.shared.getAllMarketsFirestore { [weak self] result in
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddMarket))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: "marketCell")
        tableView.separatorStyle = .singleLine
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return markets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "marketCell",for: indexPath) as? MarketTableViewCell else {
            fatalError("Can not dequeue market table view cell with identifier")
        }

        // print(markets[indexPath.row].id)
        
        cell.shopName.text = markets[indexPath.row].shopName
        
        let date = markets[indexPath.row].createdAt.dateValue()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy--MM--dd HH:mm:ss ZZZ"
        let formattedTime = formatter.string(from: date)
        
        cell.createdAt.text = formattedTime

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableConstants.cellHeight)
    }
    
    // TODO: Refine
    
    @objc func didTapAddMarket() {
        let market = Market(shopName: "shit best", createdAt: Timestamp(date: Date.now))
        DBManager.shared.addMarketFirestore(market: market) { result in
            if result == false {
                print ("error")
                return
            }
            
            print("success add market TEST!")
        }
    }
}
