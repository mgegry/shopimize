//
//  MItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 18/03/2022.
//

import UIKit

/// Item view controller for the market admin app

class MItemViewController: UIViewController {
    
    /// The table view that displays the items
    var tableView = UITableView(frame: .zero, style: .plain)
    
    /// The items to be displayed
    var items: [Item] = []
    
    /// The id of the market for which to display the items
    var marketID: String?
    
    // MARK: View Lifecycle
    
    /// Do any aditional setup before the view is about to appear
    override func viewWillAppear(_ animated: Bool) {
        if let mid = marketID {
            DBItemManager.shared.getItemsForMarketFirestore(marketID: mid) { [weak self] result in
                guard let strongSelf = self else { return }
                
                switch result {
                    case.success(let items):
                        strongSelf.items = items
                        DispatchQueue.main.async {
                            strongSelf.tableView.reloadData()
                        }
                    case .failure(_):
                        // TODO: REFINE
                        print("error get items for market firestore MItemViewController")
                }
            }
        }
    }
    
    /// Do any aditional setup after the view was loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        setupTable()
        setupConstraints()
    }
    
    // MARK: Class methods
    
    /// Setup the table view
    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "marketAppItemCell")
    }
    
    /// Setup the constraints for the views
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: Extensions

/// Make HomeViewController conform to UITableViewDataSources and UITableViewDelegate so that it can implement its methods
extension MItemViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// Set the content of the cell at the given indexPath
    ///
    /// - parameter tableView: The current table view
    /// - parameter indexPath: The index path for which to set the cotent
    /// - returns: a UITableViewCell containing the cell content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketAppItemCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = items[indexPath.row].itemName
        content.image = UIImage(systemName: "photo")
        cell.contentConfiguration = content
        
        return cell
    }
    
    /// Set the number of sections for the table
    ///
    /// - parameter tableView: The current table
    /// - returns: The number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Set the number of rows for the current section
    ///
    /// - parameter tableView: The current table view
    /// - parameter section: The current section
    /// - returns: The number of rowns in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
