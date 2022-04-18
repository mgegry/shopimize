//
//  FriendRequestTableViewCell.swift
//  shopimize
//
//  Created by Mircea Egry on 17/04/2022.
//

import UIKit

class FriendRequestTableViewCell: UITableViewCell {

//    var acceptFriendRequestAction: (() -> ())?
//    var declineFriendRequestAction: (() -> ())?
    
    /// Container holding the card for the cell
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
        stackView.spacing = 1
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
//    var buttonStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.spacing = 1
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.alignment = .fill
//        return stackView
//    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person")
        image.contentMode = .scaleAspectFit
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return image
    }()
    
    var userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFit
        label.textColor = .black
        return label
    }()
    
    var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFit
        label.textColor = .black
        return label
    }()
    
//    var acceptFriendRequestButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        let config = UIImage.SymbolConfiguration(pointSize: 20)
//        button.setImage(UIImage(systemName: "person.fill.checkmark", withConfiguration: config), for: .normal)
//        button.tintColor = .systemGreen
//        return button
//    }()
//
//    var declineFriendRequestButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        let config = UIImage.SymbolConfiguration(pointSize: 20)
//        button.setImage(UIImage(systemName: "person.fill.xmark", withConfiguration: config), for: .normal)
//        button.tintColor = .systemRed
//        return button
//    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .backgroundGrey
        setupContainer()
        setupConstraints()
//        setupButtons()
    }
    
    /// No support for storyboards so the initializer is set to unavailable
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//
//    private func setupButtons() {
//        acceptFriendRequestButton.addTarget(self, action: #selector(didTapAccept), for: .touchUpInside)
//        declineFriendRequestButton.addTarget(self, action: #selector(didTapDecline), for: .touchUpInside)
//    }
//
//    @objc func didTapAccept() {
//
//        acceptFriendRequestAction?()
//    }
//
//    @objc func didTapDecline() {
//        declineFriendRequestAction?()
//    }
//
    /// Setup the container with all its views
    private func setupContainer() {
        // self.contentView.backgroundColor = .clear
        self.contentView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(image)
        mainStackView.addArrangedSubview(infoStackView)
//        mainStackView.addArrangedSubview(buttonStackView)
        
        infoStackView.addArrangedSubview(userLabel)
        infoStackView.addArrangedSubview(emailLabel)
//        buttonStackView.addArrangedSubview(acceptFriendRequestButton)
//        buttonStackView.addArrangedSubview(declineFriendRequestButton)
    }
    
    /// Setup the views constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // Container constraints
            
            containerView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor,
                                               constant: CGFloat(TableConstants.cellVerticalInset)),
            
            containerView.rightAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.rightAnchor,
                                                 constant: -CGFloat(TableConstants.cellHorizontalInset)),
            
            containerView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor,
                                                  constant: -CGFloat(TableConstants.cellVerticalInset)),
            
            containerView.leftAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leftAnchor,
                                                constant: CGFloat(TableConstants.cellHorizontalInset)),

            
//            buttonStackView.widthAnchor.constraint(equalToConstant: 60),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            mainStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            mainStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            image.widthAnchor.constraint(equalToConstant: 80),
        ])
    }

}