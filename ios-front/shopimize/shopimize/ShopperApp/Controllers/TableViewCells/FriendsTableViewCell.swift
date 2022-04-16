//
//  FriendsTableViewCell.swift
//  shopimize
//
//  Created by Mircea Egry on 16/04/2022.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    // Views declaration and their properties are declared as computed properties
    // so that they are lazy instanciated
    
    /// Container holding the card for the cell
    var containerView: UIView = {
        let view = UIView()
        // TODO: Create shadow with beziere path to be more eficient
        /// https://stackoverflow.com/questions/37645408/uitableviewcell-rounded-corners-and-shadow
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
    
    var testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .backgroundGrey
        setupContainer()
        setupConstraints()
    }
    
    /// No support for storyboards so the initializer is set to unavailable
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Setup the container with all its views
    private func setupContainer() {
        // self.contentView.backgroundColor = .clear
        addSubview(containerView)
        addSubview(testLabel)
    }
    
    /// Setup the views constraints
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
            
            // Test Label constraints
            
            testLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            testLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            testLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

}
