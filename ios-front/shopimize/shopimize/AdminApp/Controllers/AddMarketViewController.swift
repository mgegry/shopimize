//
//  AddMarketViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 24/03/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddMarketViewController: UIViewController {
    
    let mainView = AddMarketView()
    
    var stores: [Store] = []
    var selectedStore: String?
    
    // MARK: View Lifecycle
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .white
        
        mainView.storePicker.delegate = self
        mainView.storePicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DBStoreManager.shared.getAllStores { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
                case .success(let stores):
                    strongSelf.stores = stores
                    DispatchQueue.main.async {
                        strongSelf.mainView.storePicker.reloadAllComponents()
                    }
                case.failure(_):
                    // TODO: REFINE
                    print("Error getting all stores")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: UIResponder.keyboardDidChangeFrameNotification,
                                       object: nil)
        
        mainView.addMarketButton.addTarget(self, action: #selector(didTapAddMarket), for: .touchUpInside)
        
    }
    
    // MARK: Class methods
    
    @objc func didTapAddMarket() {
        guard let address = mainView.street.text, let postcode = mainView.postcode.text, let city = mainView.city.text, let store = selectedStore else {
            // TODO: REFINE
            print("Please fill in all the fields")
            return
        }
        
        let updatedAddress = address.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let updatedCity = city.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let updatedPostcode = postcode.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        var market = Market(street: updatedAddress, postalCode: updatedPostcode, city: updatedCity,
                            geoLocation: GeoPoint(latitude: 0, longitude: 0), createdAt: Timestamp(date: Date.now),
                            isActive: mainView.isActiveSwitch.isOn, storeID: store)
        
        GoogleMapsManager.shared.decodeAddressToLocation(address: updatedAddress, city: updatedCity, postalcode: updatedPostcode) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
                case .success(let loc):
                    let geoLocation = GeoPoint(latitude: loc.latitude, longitude: loc.longitude)
                    market.geoLocation = geoLocation
                    
                    DBMarketManager.shared.addMarketFirestore(market: market) { result in
                        guard result == true else {
                            // TODO: REFINE
                            print("can not add market to firebastore collection")
                            return
                        }
                        DispatchQueue.main.async {
                            strongSelf.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                case .failure(_):
                    // TODO: REFINE
                    print("can not decode address to location")
                    return
            }
        }
        
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            mainView.scrollView.contentInset = .zero
        } else {
            mainView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                            bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        mainView.scrollView.scrollIndicatorInsets = mainView.scrollView.contentInset

    }
    
}

// MARK: Extensions

extension AddMarketViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stores[row].name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedStore = stores[row].id
    }
}
