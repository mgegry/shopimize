//
//  ViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import FirebaseAuth
import GoogleMaps
import UIKit

/// Controller for the map view of the app

class MapViewController: UIViewController {
    
    /// Handles the state of the user; changes if the user logs out or in
    private var handle: AuthStateDidChangeListenerHandle?
    
    /// Do any aditional setup before the view is about to appear
    ///
    /// - parameter animated: States if the view will apear animated or not
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            
            guard let user = user else {
                print("no user found")
                
                let startViewController = StartViewController()
                let navController = UINavigationController(rootViewController: startViewController)
                
                navController.modalPresentationStyle = .fullScreen
                
                DispatchQueue.main.async {
                    self?.present(navController, animated: false, completion: nil)
                }
                return
            }
            print(user.email ?? "jaja")
        }
        
    }
    
    /// Do any aditional setup after the view loaded
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapLogout))
        
    }

    /// Do any aditional setup after the view is about to disapear
    ///
    /// - parameter animated: States if the view will disapear animated or not
    override func viewWillDisappear(_ animated: Bool) {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        } else {
            print("[info]:: user state did change listener was not set")
        }
    }
    
    /// Called when the user taps the log out button
    @objc func didTapLogout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
    

}

