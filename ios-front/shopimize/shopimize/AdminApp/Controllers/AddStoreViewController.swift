//
//  MAddItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 18/03/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class AddStoreViewController: UIViewController {
    
    let mainView = AddStoreView()
    
    // MARK: View Lifecycle
    
    override func loadView() {
        view = mainView
        view.backgroundColor = .white
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
        
        mainView.addStoreButton.addTarget(self, action: #selector(didTapAddStore), for: .touchUpInside)
        
    }
    
    // MARK: Class methods
    
    @objc func didTapAddStore() {
        guard let name = mainView.name.text else { return }
        let store = Store(name: name, isActive: mainView.isActiveSwitch.isOn, createdAt: Timestamp(date: Date.now))
        
        DBStoreManager.shared.addStoreToFirebase(store: store) { [weak self] result in
            guard let strongSelf = self else { return }
            
            if result {
                strongSelf.navigationController?.popViewController(animated: true)
            } else {
                // TODO: REFINE
                print("Could not add store")
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
