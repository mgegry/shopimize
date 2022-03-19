//
//  MAddItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 18/03/2022.
//

import UIKit
import FirebaseStorage

class MAddItemViewController: UIViewController {

    /// price date-added is-active photo name description markets shop
    
    var itemImage: UIImage? {
        didSet {
            let buttonImage = UIImage(systemName: "photo")?.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)
            
            addItemView.addImageButton.setTitle("Change image", for: .normal)
            addItemView.addImageButton.setImage(buttonImage, for: .normal)
        }
    }
    
    let addItemView = AddItemView()
    
    // MARK: View Lifecycle
    
    override func loadView() {
        view = addItemView
        view.backgroundColor = .white
        
        addItemView.price.delegate = self
        
        addItemView.marketPicker.delegate = self
        addItemView.marketPicker.dataSource = self
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
        
        addItemView.addImageButton.addTarget(self, action: #selector(didTapAddImage), for: .touchUpInside)
        addItemView.addItemButton.addTarget(self, action: #selector(didTapAddItem), for: .touchUpInside)
        
    }
    
    // MARK: Class methods
    
    @objc func didTapAddItem() {
        
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
            addItemView.scrollView.contentInset = .zero
        } else {
            addItemView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        addItemView.scrollView.scrollIndicatorInsets = addItemView.scrollView.contentInset

    }
    
}

// MARK: Extension

extension MAddItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true, completion: nil)
        itemImage = image
    }
}

extension MAddItemViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        
        let dot: Character = "."
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.filter({ $0 == dot }).count > 1 { return false }
        
        return updatedText.count <= 6
        
    }
}

extension MAddItemViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
