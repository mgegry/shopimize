//
//  AddFriendView.swift
//  shopimize
//
//  Created by Mircea Egry on 17/04/2022.
//

import UIKit

class AddFriendView: UIView {

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Friend username:"
        label.font = UIFont(name: ViewConstants.fontName,
                            size: ViewConstants.smallFontSize)
        label.baselineAdjustment = .alignCenters
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let username: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.placeholder = "example123"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        textField.layer.cornerRadius = ViewConstants.formFieldCornerRadius
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        return textField
    }()
    
    let usernameStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    let addFriendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send friend request", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundGrey
        
        setupSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(usernameStack)
        stackView.addArrangedSubview(addFriendButton)
        
        usernameStack.addArrangedSubview(usernameLabel)
        usernameStack.addArrangedSubview(username)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10),
            stackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10),
//            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            usernameStack.heightAnchor.constraint(equalToConstant: 100),
            addFriendButton.heightAnchor.constraint(equalToConstant: 35)
            
        ])
    }
    
}
