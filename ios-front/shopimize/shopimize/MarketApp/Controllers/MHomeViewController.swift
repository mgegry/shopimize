//
//  HomeViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 16/03/2022.
//

import UIKit
import FirebaseAuth

/// Home view controller for the Admin Market App
class MHomeViewController: UIViewController {
    
    /// Struct containing the declaration of a section
    struct Section {
        var headerTitle: String?
        var cells: [UITableViewCell]
    }
    /// Array containng all sections of the table
    var sections: [Section] = []
    
    /// Table view declaration
    var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    /// Table view cells declaration
    let myAccountCell = UITableViewCell(style: .value1, reuseIdentifier: "")
    let addItemCell = UITableViewCell(style: .value1, reuseIdentifier: "")
    let allItemsCell = UITableViewCell(style: .value1, reuseIdentifier: "")
    let inStoreSalesCell = UITableViewCell(style: .value1, reuseIdentifier: "")
    let pointsSalesCell = UITableViewCell(style: .value1, reuseIdentifier: "")
    let signOutCell = UITableViewCell(style: .value1, reuseIdentifier: "")
    
    /// Do any aditional setup after the view was loaded
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        setupNavigation()
        buildTableCells()
        buildTableSections()
        setupTable()
        setupConstraints()
    }
    
    // MARK: Class methods
    
    /// Setup the table for the view
    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
//        tableView.insetsContentViewsToSafeArea = true
//        tableView.sectionHeaderTopPadding = 25
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "marketAdminCell")
        tableView.register(UITableViewHeaderFooterView.self,
                           forHeaderFooterViewReuseIdentifier: "markedAdminHeaderCell")
    }
    
    /// Set the content of the cells
    private func buildTableCells() {
        var content = myAccountCell.defaultContentConfiguration()
        content.text = "My account"
        myAccountCell.contentConfiguration = content
        
        content = addItemCell.defaultContentConfiguration()
        content.text = "Add item"
        addItemCell.contentConfiguration = content
        
        content = allItemsCell.defaultContentConfiguration()
        content.text = "All items"
        allItemsCell.contentConfiguration = content
        
        content = inStoreSalesCell.defaultContentConfiguration()
        content.text = "In store sales"
        inStoreSalesCell.contentConfiguration = content
        
        content = pointsSalesCell.defaultContentConfiguration()
        content.text = "Points sales"
        pointsSalesCell.contentConfiguration = content
        
        content = signOutCell.defaultContentConfiguration()
        content.text = "Sign out"
        content.textProperties.color = UIColor(.red)
        signOutCell.contentConfiguration = content
    }
    
    /// Build the sections for the table
    private func buildTableSections() {
        
        sections = [
            Section(headerTitle: "Account management", cells: [myAccountCell]),
            //Section(headerTitle: "Manage Markets", cells: [])
            Section(headerTitle: "Manage Items", cells: [addItemCell, allItemsCell]),
            Section(headerTitle: "Sales", cells: [inStoreSalesCell, pointsSalesCell]),
            Section(headerTitle: nil, cells: [signOutCell])
        ]
    }
    
    /// Setup the navigation for the view
    private func setupNavigation() {
        navigationItem.title = "Shopimize Market Panel"
    }
    
    /// Setup the view constraints
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
extension MHomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// Set the content of the cell at the given indexPath
    ///
    /// - parameter tableView: The current table view
    /// - parameter indexPath: The index path for which to set the cotent
    /// - returns: a UITableViewCell containing the cell content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].cells[indexPath.row]
    }
    
    /// Set the number of sections for the table
    ///
    /// - parameter tableView: The current table
    /// - returns: The number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    /// Set the number of rows for the current section
    ///
    /// - parameter tableView: The current table view
    /// - parameter section: The current section
    /// - returns: The number of rowns in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    /// Set the header title for the given section
    ///
    /// - parameter tableView: The current table
    /// - parameter section: The section for which to set the title
    /// - returns: The title for the section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }
    
    /// Execute action based on selected cell
    ///
    /// - parameter tableView: The current table
    /// - parameter indexPath: The index of the selected cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 && indexPath.row == 0 {
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print("Error signing out: \(signOutError)")
            }
            navigationController?.dismiss(animated: true, completion: nil)
        }
    }
}
