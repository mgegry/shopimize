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
    
    // MARK: View Lifecycle
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .white
        
        mainView.storePicker.delegate = self
        mainView.storePicker.dataSource = self
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
        guard let address = mainView.street.text, let postcode = mainView.postcode.text, let city = mainView.city.text else {
            // TODO: REFINE
            print("Please fill in all the fields")
            return
        }
        
        let market = Market(street: address, postalCode: postcode, city: city,
                            geoLocation: GeoPoint(latitude: 0, longitude: 0), createdAt: Timestamp(date: Date.now),
                            isActive: mainView.isActiveSwitch.isOn, storeID: "whatever")
        
        
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

extension AddMarketViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "fuata"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
