//
//  MAddItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 18/03/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

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
    
    var markets: [Market] = []
    var marketIdSelected: String = ""
    
    // MARK: View Lifecycle
    
    override func loadView() {
        view = addItemView
        view.backgroundColor = .white
        
        addItemView.price.delegate = self
        
        addItemView.marketPicker.delegate = self
        addItemView.marketPicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "queue")
        
        guard let email = Auth.auth().currentUser?.email else { return }
        
        var user: User?
        var marketsRespons: [Market] = []
        
        group.enter()
        queue.async {
            DBUserManager.shared.getUserFirestore(withEmail: email) { result in
                switch result {
                    case .success(let s):
                        user = s
                    case .failure(_):
                        print("failure add item get user")
                }
                group.leave()
            }
        }
        
        queue.async {
            group.wait()
            guard let storeID = user?.roleStoreID else { return }
            group.enter()
            DBMarketManager.shared.getAllMarketsForStoreFirestore(store: storeID) { result in
                switch result {
                    case .success(let markets):
                        marketsRespons = markets
                    case .failure(_):
                        print("failure gettng all markets firestore")
                }
                group.leave()
            }
            group.notify(queue: .main) { [weak self] in
                self?.markets = marketsRespons
                if let id = marketsRespons[0].id {
                    self?.marketIdSelected = id
                }
                self?.addItemView.marketPicker.reloadAllComponents()
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
        
        addItemView.addImageButton.addTarget(self, action: #selector(didTapAddImage), for: .touchUpInside)
        addItemView.addItemButton.addTarget(self, action: #selector(didTapAddItem), for: .touchUpInside)
        
    }
    
    // MARK: Class methods
    
    @objc func didTapAddItem() {
        
        let item = Item(itemName: addItemView.name.text ?? "",
                        price: Double(addItemView.price.text ?? "10.0") ?? 10.0,
                        marketID: marketIdSelected,
                        description: addItemView.itemDescription.text ?? "",
                        createdAt: Timestamp(date: Date.now),
                        isActive: addItemView.isActiveSwitch.isOn)
        
        var itemID = ""
        var imageURL = ""
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "saveItemQueue")
        
        group.enter()
        queue.async {
            DBItemManager.shared.addItemToFirestore(item: item) { result in
                
                if let item_id = result {
                    itemID = item_id
                } else {
                    // TODO: DISPLAY ALERT
                }
                group.leave()
            }
        }
        
        if let image = itemImage {
            
            queue.async { [weak self] in
                group.wait()
                let path = "item_images/" + itemID + "/itemImage.png"
                group.enter()
                StorageManager.shared.addImageToFirebaseStorage(image, toPath: path) { result in
                    if result {
                        DispatchQueue.main.async {
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                    else {
                        // TODO: DIsplay alert
                    }
                    group.leave()
                }
            }
            
            queue.async {
                group.wait()
                group.enter()
                StorageManager.shared.getItemPictureURL(picture_id: itemID) { result in
                    switch (result) {
                        case .success(let url):
                            imageURL = url.absoluteString
                        case .failure(_):
                            print("error1")
                    }
                    group.leave()
                }
            }
            
            queue.async {
                group.wait()
                group.enter()
                DBItemManager.shared.addImageUrlForItem(withId: itemID, imagePath: imageURL) { result in
                    if (!result) {
                        print("error")
                    }
                    group.leave()
                }
            }
        }
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
            addItemView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                               bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
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
        
        return markets[row].street + "," + markets[row].postalCode
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return markets.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.marketIdSelected = markets[row].id!
    }
}
