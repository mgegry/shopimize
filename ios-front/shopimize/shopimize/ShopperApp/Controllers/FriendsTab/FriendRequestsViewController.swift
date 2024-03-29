//
//  FriendRequestsViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 16/04/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FriendRequestsViewController: UIViewController {
    
    let tableView = UITableView()
    
    var users: [User] = []
    var friendRequests: [FriendRequest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGrey
        
        setupNavigation()
        setupTable()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var friendRequests: [FriendRequest] = []
        var users: [User] = []
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "friendRequestQueue")
        
        guard let userEmail = Auth.auth().currentUser?.email else { return }
        
        group.enter()
        queue.async {
            DBFriendManager.shared.getAllFriendRequests(forUser: userEmail) { result in
                switch result {
                    case .success(let requests):
                        friendRequests = requests
                        
                    case .failure(_):
                        print("xd")
                        
                }
                group.leave()
            }
        }
        
        queue.async {
            group.wait()
            for friendRequest in friendRequests {
                group.enter()
                DBUserManager.shared.getUserFirestore(withEmail: friendRequest.fromUser) { result in
                    switch result {
                        case .success(let user):
                            users.append(user)
                        case .failure(_):
                            print("Error getting friend requests")
                    }
                    group.leave()
                }
            }
            group.notify(queue: .main) { [weak self] in
                self?.users = users
                self?.friendRequests = friendRequests
                self?.tableView.reloadData()
            }
        }
    }
    
    
    private func setupTable() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .backgroundGrey
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FriendRequestTableViewCell.self, forCellReuseIdentifier: "friendRequestCell")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        navigationItem.title = "Friend requests"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}

// MARK: EXTENSIONS

extension FriendRequestsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Accept friend request from \(users[indexPath.row].username!)?",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.actionSheet)
        guard let id = friendRequests[indexPath.row].id else { return }
        let friend = Friend(friendship: [friendRequests[indexPath.row].toUser, friendRequests[indexPath.row].fromUser],
                            createdAt: Timestamp(date: Date.now))
        
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: { _ in
            /// Create friendsip
            
            let group = DispatchGroup()
            let queue = DispatchQueue(label: "addFriendQueue")
            
            group.enter()
            queue.async {
                DBFriendManager.shared.deleteFriendRequest(withId: id) { result in
                    guard result == true else {
                        let secondAlert = UIAlertController(title: "Unable to respond to request",
                                                            message: "",
                                                            preferredStyle: .alert)
                        secondAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        DispatchQueue.main.async { [weak self] in
                            self?.present(alert, animated: true, completion: nil)
                        }
                        return
                    }
                    group.leave()
                }
            }
            
            queue.async {
                group.wait()
                group.enter()
                DBFriendManager.shared.addFriend(friend: friend) { result in
                    guard result == true else {
                        let secondAlert = UIAlertController(title: "Unable to respond to request",
                                                            message: "",
                                                            preferredStyle: .alert)
                        secondAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        DispatchQueue.main.async { [weak self] in
                            self?.present(alert, animated: true, completion: nil)
                        }
                        return
                    }
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.users.remove(at: indexPath.row)
                        self?.friendRequests.remove(at: indexPath.row)
                        self?.tableView.reloadData()
                    }
                    group.leave()
                }
            }
        }))
            
        alert.addAction(UIAlertAction(title: "Decline", style: .default, handler: { _ in
            
            DBFriendManager.shared.deleteFriendRequest(withId: id) { result in
                guard result == true else {
                    let secondAlert = UIAlertController(title: "Unable to respond to request",
                                                        message: "",
                                                        preferredStyle: .alert)
                    secondAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    DispatchQueue.main.async { [weak self] in
                        self?.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.users.remove(at: indexPath.row)
                    self?.friendRequests.remove(at: indexPath.row)
                    self?.tableView.reloadData()
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendRequestCell", for: indexPath) as? FriendRequestTableViewCell else {
            fatalError("Can not dequeue cell with identifier friendsCell")
        }
        
        cell.userLabel.text = users[indexPath.row].username
        cell.emailLabel.text = users[indexPath.row].id
        
        if let imageUrl = users[indexPath.row].imageUrl {
            StorageManager.shared.fetchImage(from: URL(string: imageUrl)!) { data in
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    cell.image.image = UIImage(data: data)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableConstants.friendsCellHeight)
    }
}
