//
//  AppDelegate.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import FirebaseCore
import GoogleMaps
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// Add API KEY for Goole Maps
        GMSServices.provideAPIKey("AIzaSyDZtCb83OMuZbz3Npqrlfm378VajVG2Z20")
        
        /// Configure Firebase
        FirebaseApp.configure()
        
        let tabBarController = UITabBarController()
        
        let mapViewController = MapViewController()
        let marketViewController = MarketTableViewController(style: .plain)
        let profileViewController = ProfileTableViewController(style: .plain)
        
        let navigationMapController = UINavigationController(rootViewController: mapViewController)
        let navigationProfileController = UINavigationController(rootViewController: profileViewController)
        let navigationMarketController = UINavigationController(rootViewController: marketViewController)
        
        
        let marketAdminViewController = MHomeViewController()
        
        let navigationAdminMarketController = UINavigationController(rootViewController: marketAdminViewController)
        
        
        tabBarController.setViewControllers([navigationMarketController, navigationMapController, navigationProfileController, navigationAdminMarketController], animated: true)
        
        window = UIWindow()
        
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

