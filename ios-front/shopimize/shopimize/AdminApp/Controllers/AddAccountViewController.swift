//
//  AddAccountViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 23/03/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class AddAccountViewController: UIViewController {
    
    let mainView = AddAccountView()
    
    private var stores: [Store] = []
    
    private var storeSelection: String?
    private var accountSelection: String = "market"
    
    // MARK: View Lifecycle
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .white
        
        mainView.accountPicker.delegate = self
        mainView.accountPicker.dataSource = self
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
                    strongSelf.mainView.storePicker.reloadAllComponents()
                case .failure(_):
                    // TODO: REFINE
                    print("failure")
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
        
        mainView.addAccountButton.addTarget(self, action: #selector(didTapAddAccount), for: .touchUpInside)
        
    }
    
    // MARK: Class methods
    
    @objc func didTapAddAccount() {
        guard let email = mainView.email.text, let password = mainView.password.text, let store = storeSelection else {
            // TODO: ADD ALERT
            print("something")
            return
        }
        
        let user = User(role: accountSelection, roleStoreID: store)
        
        FBAuthManager.shared.createUserFirebase(withEmail: email, password: password) { [weak self] result in
            guard let strongSelf = self else { return }
            
            guard result == true else {
                print("error") // TODO: ADD ALERT
                return
            }
            
            DBUserManager.shared.addUserFirestore(with: email, user: user) { result in
                guard result == true else {
                    print("error") // TODO: ADD ALERT
                    return
                }
                strongSelf.navigationController?.popViewController(animated: true)
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
            mainView.scrollView.contentInset = UIEdgeInsets(top: 0,
                                                            left: 0,
                                                            bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom,
                                                            right: 0)
        }

        mainView.scrollView.scrollIndicatorInsets = mainView.scrollView.contentInset

    }
    
}

// MARK: Extension

extension AddAccountViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            if row == 0 {
                return "Market Admin"
            } else {
                return "Super User"
            }
        } else {
            return stores[row].name
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            return 2
        }
        
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            if row == 0 {
                self.accountSelection = "market"
            } else {
                self.accountSelection = "superuser"
            }
        } else {
            self.storeSelection = stores[row].id
        }
    }
}
