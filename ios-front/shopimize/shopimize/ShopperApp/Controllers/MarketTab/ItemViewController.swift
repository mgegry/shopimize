//
//  ItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 15/03/2022.
//

import UIKit

class ItemViewController: UIViewController {
    
    /// The array of items to display
    var items: [Item] = []
    
    /// The market id for which to display items
    var marketID: String = ""
    
    /// Collection View declaration
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        viewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: 280)
        viewLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        // viewLayout.sectionHeadersPinToVisibleBounds = true
        // viewLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 20)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    // MARK: View Lifecyle Functions
    
    /// Do any aditional setup after loading the view
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundGrey
        view.addSubview(collectionView)
        
        setupNavigation()
        setupCollectionView()
        setupConstraints()
    }
    
    /// Do any aditional setup before the view is about to appear
    ///
    /// - parameter animated: States if the view will appear animated or not
    override func viewWillAppear(_ animated: Bool) {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "getItemsQueue")
        
        var items_request: [Item] = []
        
        let id = marketID
        
        guard items.isEmpty else { return }
        
        group.enter()
        queue.async {
            DBItemManager.shared.getItemsForMarketFirestore(marketID: id) { result in
                
                switch result {
                case .success(let items):
                    items_request = items
                    
                case .failure(_):
                    print("Unable to get items for market \(id)")
                }
                group.leave()
            }
            group.notify(queue: .main) { [weak self] in
                self?.items = items_request
                self?.collectionView.reloadData()
            }
        }
        
        queue.async {
            group.wait()
            for i in items_request.indices {
                if let url = items_request[i].imageURL {
                    group.enter()
                    StorageManager.shared.fetchImage(from: URL(string: url)!) { data in
                        items_request[i].image = UIImage(data: data!)
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) { [weak self] in
                self?.items = items_request
                self?.collectionView.reloadData()
            }
        }
    }
    
    // MARK: Class functions
    
    /// Setup the colletion view properties
    ///
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        //self.collectionView.alwaysBounceVertical = true
        
        self.collectionView.backgroundColor = .backgroundGrey
        self.collectionView.register(ItemTableViewCell.self, forCellWithReuseIdentifier: "itemCellC")
        self.collectionView.register(UICollectionViewCell.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: "header")
    }
    
    /// Setup the constraints for the views
    ///
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        navigationItem.title = "Items"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: Extensions

/// Extension to ItemViewController conforming to UICollectionViewDataSrouce Protocol
///
extension ItemViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCellC", for: indexPath) as? ItemTableViewCell else {
            fatalError("Could not deque cell with identifier itemCellC")
        }
        cell.image.image = UIImage(systemName: "person")
        cell.nameLabel.text = items[indexPath.row].itemName
        cell.priceLabel.text = "£ " + String(items[indexPath.row].price)
        
        if let image = items[indexPath.row].image {
            cell.image.image = image
        }
        
        return cell
    }
    
    // Header functionality
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
//            headerView.backgroundColor = .white
//            return headerView
//
//        case UICollectionView.elementKindSectionFooter:
//            print("nothing")
//
//        default:
//            print("default")
//        }
//        return UICollectionReusableView()
//    }
    
}

/// Extension to ItemViewController conforming to UICollectionViewDelegate Protocol
///
extension ItemViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = IndividualItemViewController()
        vc.item = items[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
