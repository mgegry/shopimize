//
//  ViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import FirebaseAuth
import FirebaseFirestore
import GoogleMaps
import UIKit
import MapKit

/// Controller for the map view of the app

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    /// Handles the state of the user; changes if the user logs out or in
    private var handle: AuthStateDidChangeListenerHandle?
    private let locationManager: CLLocationManager = CLLocationManager()
    
    /// Do any aditional setup before the view is about to appear
    ///
    /// - parameter animated: States if the view will apear animated or not
    override func viewWillAppear(_ animated: Bool) {
        
        locationManager.startUpdatingLocation()
//        handle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
//
//            guard let user = user else {
//                print("no user found")
//
//                let startViewController = StartViewController()
//                let navController = UINavigationController(rootViewController: startViewController)
//
//                navController.modalPresentationStyle = .fullScreen
//
//                DispatchQueue.main.async {
//                    self?.present(navController, animated: false, completion: nil)
//                }
//                return
//            }
//            print(user.email ?? "jaja")
//        }
        
    }
    
    /// Do any aditional setup after the view loaded
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundGrey
        
        setupNavbar()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()

        let url = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=sheffield%20s37lg&key=AIzaSyDZtCb83OMuZbz3Npqrlfm378VajVG2Z20")!

        var location = CLLocationCoordinate2D()
        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//
//            if let data = data {
//                do {
//                    let json = try JSONDecoder().decode(LocationRequest.self, from: data)
//                    location.latitude = json.results[0].geometry.location.lat
//                    location.longitude = json.results[0].geometry.location.lng
//                    DispatchQueue.main.async {
//                        marker.position = location
//                        marker.title = "Sydney"
//                        marker.snippet = "Australia"
//                        marker.map = mapView
//                    }
//
//                } catch let e {
//                    print (e)
//                }
//
//            } else if let error = error {
//                print("HTTP Request Failed \(error)")
//            }
//        }
//        task.resume()
        
    }
    
    private func setupNavbar() {
        guard let nav = navigationController else { return }
        
        let boundsWidth = nav.navigationBar.bounds.width - NavigationConstants.navigationInset
        let boundsHeight = nav.navigationBar.bounds.height
        
        
        let titleView = MapNavigation(frame: CGRect(x: 0, y: 0, width: boundsWidth, height: boundsHeight))
        self.navigationItem.titleView = titleView
    }

    /// Do any aditional setup after the view is about to disapear
    ///
    /// - parameter animated: States if the view will disapear animated or not
    override func viewWillDisappear(_ animated: Bool) {
//        if let handle = handle {
//            Auth.auth().removeStateDidChangeListener(handle)
//        } else {
//            print("[info]:: user state did change listener was not set")
//        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("Failed to find user's location: \(error.localizedDescription)")
    }

}

