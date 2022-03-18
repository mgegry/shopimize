//
//  MItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 18/03/2022.
//

import UIKit

class MItemViewController: UIViewController {
    
    var tableView = UITableView(frame: .zero, style: .plain)
    var items: [Item] = []
    
    var marketID: String?
    
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

extension MItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketAppItemCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = items[indexPath.row].itemName
        content.image = UIImage(systemName: "photo")
        cell.contentConfiguration = content
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
