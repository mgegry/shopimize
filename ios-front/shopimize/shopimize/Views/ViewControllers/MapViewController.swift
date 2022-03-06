//
//  ViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import FirebaseAuth
import GoogleMaps
import UIKit

class MapViewController: UIViewController {
    
    private var handle: AuthStateDidChangeListenerHandle?
    
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

    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @objc func didTapLogout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
    

}

