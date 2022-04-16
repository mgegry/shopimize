//
//  LoginViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import UIKit
import FirebaseAuth
import SwiftUI

/// Controller for the login view of the app
class LoginViewController: UIViewController {
    
    /// Value holding layout and design of this view controller
    var loginView = LoginView()
    
    /// Initialize the View Controllers to be displayed for the shopper app
    let mtabBarController = UITabBarController()
    let navigationMapController = UINavigationController(rootViewController: MapViewController())
    let navigationProfileController = UINavigationController(rootViewController: ProfileTableViewController(style: .plain))
    let navigationMarketController = UINavigationController(rootViewController: MarketTableViewController(style: .plain))
    let navigationFriendsController = UINavigationController(rootViewController: FriendsViewController())
    
    /// Initialize View Controllers for the other two types of users
    let navigationAdminMarketController = UINavigationController(rootViewController: MHomeViewController())
    let navigationAdminController = UINavigationController(rootViewController: AHomeViewController())

    // MARK: Lifecyle methods
    
    /// Load the view
    override func loadView() {
        view = loginView
        view.backgroundColor = .white
    }
    
    /// Do any aditional setup after the view was loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        setupNavigationControllers()
        
        if let userEmail = Auth.auth().currentUser?.email {
            DBUserManager.shared.getUserRoleFirestore(withEmail: userEmail) { [weak self] result in
                switch result {
                    case .success(var role):
                        
                        if role != "shopper" && role != "market" && role != "superuser" {
                            role = "shopper"
                        }
                        
                        DispatchQueue.main.async {
                            self?.displayApp(basedOnRole: role)
                        }
                        
                    case .failure(_):
                        print("error")
                }
            }
        }
    }
    
    // MARK: Class methods
    
    /// Called when the login button is pressed
    @objc func didTapLogin() {
        
        FBAuthManager.shared.loginUserFirebase(withEmail: loginView.emailTextField.text ?? " ", password: loginView.passwordTextField.text ?? " ") { [weak self] result in
            
            switch result {
                case .success(let email):
                    DBUserManager.shared.getUserRoleFirestore(withEmail: email) { [weak self] result in
                        switch result {
                            case .success(var role):
                                
                                if role != "shopper" && role != "market" && role != "superuser" {
                                    role = "shopper"
                                }
                                
                                DispatchQueue.main.async {
                                    self?.displayApp(basedOnRole: role)
                                }
                                
                            case .failure(_):
                                print("error")
                        }
                    }
                case .failure(_):
                    // TODO: REFINE
                    print("failure")
            }
        }
    }
    
    /// Setup the navigation view controllers and bar controller for the user app to be displayed
    private func setupNavigationControllers() {
        navigationAdminMarketController.modalPresentationStyle = .fullScreen
        navigationAdminController.modalPresentationStyle = .fullScreen
        
        let tabViewControllers = [
            navigationMarketController,
            navigationMapController,
            navigationFriendsController,
            navigationProfileController
        ]
        
        mtabBarController.setViewControllers(tabViewControllers, animated: true)
        mtabBarController.modalPresentationStyle = .fullScreen
        mtabBarController.tabBar.backgroundColor = .backgroundGrey
        
        navigationMarketController.title = "Shop"
        navigationMarketController.tabBarItem.image = UIImage(systemName: "bag")
        navigationMarketController.tabBarItem.selectedImage = UIImage(systemName: "bag.fill")
        
        navigationMapController.title = "Journey"
        navigationMapController.tabBarItem.image = UIImage(systemName: "globe.europe.africa")
        navigationMapController.tabBarItem.selectedImage = UIImage(systemName: "globe.europe.africa.fill")
        
        navigationFriendsController.title = "Friends"
        navigationFriendsController.tabBarItem.image = UIImage(systemName: "person.2")
        navigationFriendsController.tabBarItem.selectedImage = UIImage(systemName: "person.2.fill")
        
        navigationProfileController.title = "Profile"
        navigationProfileController.tabBarItem.image = UIImage(systemName: "person")
        navigationProfileController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
    }
    
    /// Select which app to display based on the given role
    ///
    /// - parameter role: The role of the user
    private func displayApp(basedOnRole role: String) {
        if role == "shopper" {
            self.present(mtabBarController, animated: false, completion: nil)
        } else if role == "market" {
            self.present(navigationAdminMarketController, animated: false, completion: nil)
        } else if role == "superuser" {
            self.present(navigationAdminController, animated: false, completion: nil)
        }
    }
}
