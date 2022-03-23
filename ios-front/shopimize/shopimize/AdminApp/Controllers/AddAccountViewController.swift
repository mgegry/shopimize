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
    
    var itemImage: UIImage? {
        didSet {
            let buttonImage = UIImage(systemName: "photo")?.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)
            
            mainView.addImageButton.setTitle("Change image", for: .normal)
            mainView.addImageButton.setImage(buttonImage, for: .normal)
        }
    }
    
    let mainView = AddAccountView()
    
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
        
        mainView.addImageButton.addTarget(self, action: #selector(didTapAddImage), for: .touchUpInside)
        mainView.addItemButton.addTarget(self, action: #selector(didTapAddAccount), for: .touchUpInside)
        
    }
    
    // MARK: Class methods
    
    @objc func didTapAddAccount() {
        
    }
    
    @objc func didTapAddImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
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

// MARK: Extension

extension AddAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true, completion: nil)
        itemImage = image
    }
}

extension AddAccountViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "fuata"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
}
