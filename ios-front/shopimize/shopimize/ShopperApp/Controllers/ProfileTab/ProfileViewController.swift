//
//  ProfileTableViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import UIKit
import FirebaseAuth

/// Controller for the profile screen of the app

class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    var profileImage: UIImage?
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        let defaults = UserDefaults.standard
        guard let emailUser = defaults.object(forKey: "loggedInUser") as? String else { return }
        
        group.enter()
        DBUserManager.shared.getUserFirestore(withEmail: emailUser) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        
                        strongSelf.profileView.username.text = user.username
                        strongSelf.profileView.coins.text = "\(user.points ?? 0)"
                        strongSelf.profileView.email.text = user.id
                    }
                case .failure(_):
                    print("Error getting user information")
            }
            group.leave()
        }
        
        group.enter()
        StorageManager.shared.getUserProfilePicture(withEmail: emailUser) { [weak self] result in
            switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self?.profileView.profileImage.load(url: success)
                    }
                case .failure(_):
                    print("error")
            }
            group.leave()
        }
        
        setupNavbar()
        addButtonTargets()
        
        profileView.profileImage.image = UIImage(systemName: "person")
    }
    
    private func addButtonTargets() {
        profileView.changeImageButton.addTarget(self, action: #selector(didTapChangeImage), for: .touchUpInside)
        profileView.realPurchasesButton.addTarget(self, action: #selector(didTapRealPurchases), for: .touchUpInside)
        profileView.coinsPurchasesButton.addTarget(self, action: #selector(didTapCoinsPurchases), for: .touchUpInside)
        profileView.signOutButton.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
    }
    
    private func setupNavbar() {
        guard let nav = navigationController else { return }
        
        let boundsWidth = nav.navigationBar.bounds.width - NavigationConstants.navigationInset
        let boundsHeight = nav.navigationBar.bounds.height
        
        
        let titleView = ProfileNavigation(frame: CGRect(x: 0, y: 0, width: boundsWidth, height: boundsHeight))
        self.navigationItem.titleView = titleView
    }
    
    @objc func didTapChangeImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func didTapRealPurchases() {
        navigationController?.pushViewController(SMoneyPurchasesViewController(), animated: true)
    }
    
    @objc func didTapCoinsPurchases() {
        navigationController?.pushViewController(SPointPurchasesViewController(), animated: true)
    }
    
    @objc func didTapSignOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "loggedInUser")
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }

}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true, completion: nil)
        
        let group = DispatchGroup()
        let defaults = UserDefaults.standard
        
        guard let userEmail = defaults.object(forKey: "loggedInUser") as? String else { return }
        let savePath = "images/" + userEmail + "/profileImage.png"
        
        group.enter()
        StorageManager.shared.addImageToFirebaseStorage(image, toPath: savePath) { [weak self] result in
            guard let strongSelf = self else { return }
            
            if !result {
                DispatchQueue.main.async {
                    strongSelf.presentAlert()
                }
            }
            group.leave()
        }
        
        group.enter()
        DBUserManager.shared.saveProfileImageForUser(withEmail: userEmail, toPath: savePath) { [weak self] result in
            guard let strongSelf = self else { return }
            
            if !result {
                DispatchQueue.main.async {
                    strongSelf.presentAlert()
                }
            } else {
                DispatchQueue.main.async {
                    strongSelf.profileView.profileImage.image = image
                }
            }
            group.leave()
        }
        
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: "Save error",
                                      message: "Your photo was not saved",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)

    }
}
