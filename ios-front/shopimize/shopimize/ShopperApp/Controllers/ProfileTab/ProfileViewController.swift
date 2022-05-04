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
    var user: User?
    
    override func loadView() {
        view = profileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "getProfileImage")

        guard let emailUser = Auth.auth().currentUser?.email else { return }
        
        var user: User?
        
        group.enter()
        queue.async {
            DBUserManager.shared.getUserFirestore(withEmail: emailUser) { result in
                
                switch result {
                    case .success(let success):
                        user = success
                    case .failure(_):
                        print("Error getting user information")
                }
                group.leave()
            }
            group.notify(queue: .main) { [weak self] in
                self?.user = user
                self?.profileView.coins.text = "\(user?.points ?? 0)"
                self?.profileView.email.text = user?.id
                self?.profileView.username.text = user?.username
            }
        }
        
//        var url: URL?
//
//        group.enter()
//        queue.async {
//            StorageManager.shared.getUserProfilePicture(withEmail: emailUser) { result in
//                switch result {
//                    case .success(let success):
//                        url = success
//                    case .failure(_):
//                        print("error1")
//                }
//                group.leave()
//            }
//        }
//
        queue.async {
            group.wait()
            guard let url = user?.imageUrl else { return }
            group.enter()
            StorageManager.shared.fetchImage(from: URL(string: url)!) { data in
                guard let data = data else {
                    print("error2")
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.profileView.profileImage.image = UIImage(data: data)
                }
                group.leave()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            self.tabBarController?.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }

}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true, completion: nil)
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "saveProfileImage")
        
        guard let userEmail = Auth.auth().currentUser?.email else { return }
        
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
        
        var url: URL?
        
        group.enter()
        queue.async {
            guard let userEmail = Auth.auth().currentUser?.email else { return }
            StorageManager.shared.getUserProfilePicture(withEmail: userEmail) { result in
                switch result {
                    case .success(let u):
                        url = u
                    case .failure(_):
                        print("error")
                }
            }
            group.leave()
        }
        
        queue.async {
            group.wait()
            guard let safeUrl = url else { return }
            group.enter()
            DBUserManager.shared.saveProfileImageForUser(withEmail: userEmail, toPath: safeUrl.absoluteString) { [weak self] result in
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

        
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: "Save error",
                                      message: "Your photo was not saved",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)

    }
}
