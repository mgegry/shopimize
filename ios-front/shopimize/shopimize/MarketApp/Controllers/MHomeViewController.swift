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
        var cells: [FormCell]
    }
    
    /// Class containing definition of a cell
    class FormCell: UITableViewCell {
        var shouldHighlight = false
        var didSelect: (() -> ())?
    }
    
    /// Array containng all sections of the table
    var sections: [Section] = []
    
    /// Table view declaration
    var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    /// Table view cells declaration
    let myAccountCell = FormCell(style: .value1, reuseIdentifier: "")
    let addItemCell = FormCell(style: .value1, reuseIdentifier: "")
    let allItemsCell = FormCell(style: .value1, reuseIdentifier: "")
    let inStoreSalesCell = FormCell(style: .value1, reuseIdentifier: "")
    let pointsSalesCell = FormCell(style: .value1, reuseIdentifier: "")
    let signOutCell = FormCell(style: .value1, reuseIdentifier: "")
    
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
    
    /// Do any aditional setup before the view is about to appear
    ///
    /// - parameter animated: States if the view should appear animated or not
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
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
        allItemsCell.shouldHighlight = true
        allItemsCell.didSelect = { [unowned self] in
            let vc = MItemViewController()
            vc.marketID = "bcTBWviMqGrJpTsN1FQS"
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
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
        signOutCell.shouldHighlight = true
        signOutCell.didSelect = { [unowned self] in
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print("Error signing out: \(signOutError)")
            }
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
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
        cell(for: indexPath).didSelect?()
    }
    
    /// Return new created type FormCell for the given index path
    ///
    /// - parameter indexPath: The indexPath for which to return the cell
    /// - returns: The form cell coresponding to the indexPath
    func cell(for indexPath: IndexPath) -> FormCell {
        return sections[indexPath.section].cells[indexPath.row]
    }
    
    /// Return if the cell should highlight or not
    ///
    /// - parameter tableVie: The current table view
    /// - parameter indexPath: The indexPath of the cell
    /// - returns: True or false if the cell should highlight or not
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return sections[indexPath.section].cells[indexPath.row].shouldHighlight
    }
}
