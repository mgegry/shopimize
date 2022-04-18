//
//  FriendsViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 16/04/2022.
//

import UIKit
import FirebaseAuth

class FriendsViewController: UIViewController {
    
    var tableView = UITableView(frame: .zero, style: .plain)
    
    var users: [User] = []
    
    override func viewWillAppear(_ animated: Bool) {
        guard let email = Auth.auth().currentUser?.email else { return }
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "q")
        var friends: [String] = []
        
        group.enter()
        queue.async {
            DBFriendManager.shared.getAllFriends(forUser: email) { result in
                
                switch result {
                    case .success(let f):
                        friends = f

                    case .failure(_):
                        print("failure")
                }
                group.leave()
            }
        }
        
        queue.async {
            group.wait()
            group.enter()
            DBUserManager.shared.getAllUsers(withEmails: friends) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                    case .success(let users):
                        DispatchQueue.main.async {
                            strongSelf.users = users
                            strongSelf.tableView.reloadData()
                        }
                    case .failure(_):
                        print("Error getting friends")
                }
                group.leave()
            }
        }
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .backgroundGrey
        
        setupTableView()
        setupConstraints()
        setupNavbar()
        
    }
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        tableView.backgroundColor = .backgroundGrey
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(FriendsTableViewCell.self, forCellReuseIdentifier: "friendsCell")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavbar() {
        guard let nav = navigationController else { return }
        
        let boundsWidth = nav.navigationBar.bounds.width - NavigationConstants.navigationInset
        let boundsHeight = nav.navigationBar.bounds.height
        
        
        let titleView = FriendsNavigation(frame: CGRect(x: 0, y: 0, width: boundsWidth, height: boundsHeight))
        
        titleView.addFriendButton.addTarget(self, action: #selector(didTapAddFriend), for: .touchUpInside)
        titleView.friendRequestsButton.addTarget(self, action: #selector(didTapFriendRequests), for: .touchUpInside)
        
        self.navigationItem.titleView = titleView
    }
    
    @objc func didTapAddFriend() {
        let vc = UINavigationController(rootViewController: AddFriendViewController())
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.preferredCornerRadius = 20
        }
        present(vc, animated: true, completion: nil)
    }
    
    @objc func didTapFriendRequests() {
        let vc = UINavigationController(rootViewController: FriendRequestsViewController())
        present(vc, animated: true, completion: nil)
    }

}

// MARK: Extensions

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as? FriendsTableViewCell else {
            fatalError("Can not dequeue cell with identifier friendsCell")
        }
        
        cell.userLabel.text = users[indexPath.row].username
        cell.shoppingStatusLabel.text = "Currently shopping"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(FriendViewController(), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableConstants.friendsCellHeight)
    }
    
}
