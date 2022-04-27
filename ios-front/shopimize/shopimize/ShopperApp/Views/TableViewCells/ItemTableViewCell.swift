//
//  ItemTableViewCell.swift
//  shopimize
//
//  Created by Mircea Egry on 11/03/2022.
//

import UIKit

/// Class containing item table view cell design and definition

class ItemTableViewCell: UICollectionViewCell {
    
    var containerView: UIView = {
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
    
    var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
//        stackView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return stackView
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person")
        image.contentMode = .scaleAspectFit
//        image.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return image
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        self.contentView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(image)
        mainStackView.addArrangedSubview(infoStackView)
        
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(priceLabel)
    }
    
    /// Setup the views constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Container constraints
            
            containerView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor,
                                               constant: 5),
            
            containerView.rightAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.rightAnchor,
                                                 constant: -5),
            
            containerView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -5),
            
            containerView.leftAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leftAnchor,
                                                constant: 5),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            mainStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            mainStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            image.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
        ])
    }
}
