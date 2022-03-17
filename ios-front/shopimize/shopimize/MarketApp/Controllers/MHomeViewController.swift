//
//  HomeViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 16/03/2022.
//

import UIKit

/// Home view controller for the Admin Market App
class MHomeViewController: UIViewController {
    
    /// Struct containing the declaration of a section
    struct Section {
        var headerTitle: String?
        var cells: [String]
    }
    /// Array containng all sections of the table
    var sections: [Section] = []
    
    /// Table view declaration
    var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    /// Do any aditional setup after the view was loaded
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        setupNavigation()
        buildSections()
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
    
    /// Build the sections for the table
    private func buildSections() {
        sections = [
            Section(headerTitle: nil, cells: ["My Account"]),
            Section(headerTitle: nil, cells: ["All items", "Active items"]),
            Section(headerTitle: nil, cells: ["In store sales", "Points sales"]),
            Section(headerTitle: nil, cells: ["Sign out"])
        ]
    }
    
    /// Setup the navigation for the view
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Haha"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketAdminCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        
        content.text = sections[indexPath.section].cells[indexPath.row]
        cell.contentConfiguration = content
        return cell
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
