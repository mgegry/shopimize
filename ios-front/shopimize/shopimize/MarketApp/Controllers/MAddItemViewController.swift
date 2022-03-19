//
//  MAddItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 18/03/2022.
//

import UIKit

class MAddItemViewController: UIViewController {

    /// price date-added is-active photo name description markets shop
    
    let addItemView = AddItemView()
    
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
        
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            addItemView.scrollView.contentInset = .zero
        } else {
            addItemView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0,bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        addItemView.scrollView.scrollIndicatorInsets = addItemView.scrollView.contentInset

    }
    
}

// MARK: Extension

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
