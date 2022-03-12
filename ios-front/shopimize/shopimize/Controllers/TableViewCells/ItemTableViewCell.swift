//
//  ItemTableViewCell.swift
//  shopimize
//
//  Created by Mircea Egry on 11/03/2022.
//

import UIKit

/// Class containing item table view cell design and definition

class ItemTableViewCell: UITableViewCell {
    
    /// Container holding the card for the table
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
    
    /// Label for the item name
    var itemName: UILabel = {
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
    
    /// No use of storyboards so the init is set to unavailable
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    /// Setup the container with its views
    private func setupContainer () {
        addSubview(containerView)
        addSubview(itemName)
    }
    
    /// Setup the constraints for the views
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
            
            itemName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            itemName.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            
        ])
    }
}
