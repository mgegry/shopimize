//
//  MarketTableViewCell.swift
//  shopimize
//
//  Created by Mircea Egry on 06/03/2022.
//

import UIKit

class MarketTableViewCell: UITableViewCell {
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.4
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 5)
        return view
    }()
    
    var shopName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    var createdAt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainer()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    private func setupContainer () {
        addSubview(containerView)
        addSubview(shopName)
        addSubview(createdAt)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Container constraints
            
            containerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                               constant: CGFloat(TableConstants.cellVerticalInset)),
            
            containerView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,
                                                 constant: -CGFloat(TableConstants.cellHorizontalInset)),
            
            containerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -CGFloat(TableConstants.cellVerticalInset)),
            
            containerView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,
                                                constant: CGFloat(TableConstants.cellHorizontalInset)),
            
            // Shop name label constraints
            
            shopName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            shopName.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            
            // Date added constraints
            
            createdAt.topAnchor.constraint(equalTo: shopName.bottomAnchor, constant: 10),
            createdAt.leftAnchor.constraint(equalTo: shopName.leftAnchor)
        ])
    }
}
