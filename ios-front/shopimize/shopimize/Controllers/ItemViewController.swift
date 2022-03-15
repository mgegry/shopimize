//
//  ItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 15/03/2022.
//

import UIKit

class ItemViewController: UIViewController {
    
    // var collectionView = UICollectionView()
    
    var marketID: String = ""
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        viewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: UIScreen.main.bounds.width / 2 - 20)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
//    override func loadView() {
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 60, height: 60)
//        layout.scrollDirection = .horizontal
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//
//        self.view = collectionView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
        view.backgroundColor = .backgroundGrey
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        //self.collectionView.alwaysBounceVertical = true
        
        self.collectionView.backgroundColor = .backgroundGrey
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "itemCellC")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ItemViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCellC", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
}

extension ItemViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
