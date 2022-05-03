//
//  ProfileView.swift
//  shopimize
//
//  Created by Mircea Egry on 16/04/2022.
//

import UIKit

class ProfileView: UIView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        return stackView
    }()
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layer.cornerRadius = 10
        stackView.spacing = 10
        stackView.backgroundColor = .backgroundGrey
        return stackView
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    let changeImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Edit", for: .normal)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return button
    }()
    
    let profileImageStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    let coinsIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(systemName: "dollarsign.circle")
        icon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return icon
    }()
    
    let coins: CustomLabel = {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let coinsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    let usernameIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(systemName: "person.crop.square.filled.and.at.rectangle")
        icon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return icon
    }()
    
    let username: CustomLabel = {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let usernameStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    let emailIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(systemName: "paperplane")
        icon.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return icon
    }()
    
    let email: CustomLabel = {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let emailStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layer.cornerRadius = 10
        stackView.spacing = 10
        stackView.backgroundColor = .backgroundGrey
        return stackView
    }()
    
    let realPurchasesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Money purchase history", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        return button
    }()

    let coinsPurchasesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Coins purchase history", for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let signOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Sign out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        return button
    }()

    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundGrey
        
        setupViews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("This class does not support NSCoder")
    }
    
    // MARK: Class methods
    
    private func setupViews() {
        self.addSubview(scrollView)
        
        scrollView.addSubview(container)
        
        container.addSubview(stackView)
        
        stackView.addArrangedSubview(profileImageStackView)
        stackView.addArrangedSubview(headerStackView)
        stackView.addArrangedSubview(bodyStackView)
        
        headerStackView.addArrangedSubview(coinsStackView)
        headerStackView.addArrangedSubview(usernameStackView)
        headerStackView.addArrangedSubview(emailStackView)

        bodyStackView.addArrangedSubview(realPurchasesButton)
        bodyStackView.addArrangedSubview(coinsPurchasesButton)
        bodyStackView.addArrangedSubview(signOutButton)
        
        profileImageStackView.addArrangedSubview(profileImage)
        profileImageStackView.addArrangedSubview(changeImageButton)
        coinsStackView.addArrangedSubview(coinsIcon)
        coinsStackView.addArrangedSubview(coins)
        usernameStackView.addArrangedSubview(usernameIcon)
        usernameStackView.addArrangedSubview(username)
        emailStackView.addArrangedSubview(emailIcon)
        emailStackView.addArrangedSubview(email)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            container.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: container.topAnchor),
            stackView.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -ViewConstants.formPadding),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -ViewConstants.formBottomPadding),
            stackView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: ViewConstants.formPadding),
            
//            headerStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            
            profileImage.heightAnchor.constraint(equalToConstant: 200),
            
//            usernameStackView.leftAnchor.constraint(equalTo: headerStackView.leftAnchor, constant: 10),
//            coinsStackView.leftAnchor.constraint(equalTo: headerStackView.leftAnchor, constant: 10),
//            emailIcon.leftAnchor.constraint(equalTo: emailStackView.leftAnchor, constant: 10),
            
            usernameStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            coinsStackView.heightAnchor.constraint(equalTo: usernameStackView.heightAnchor),
            emailStackView.heightAnchor.constraint(equalTo: usernameStackView.heightAnchor),
            
            usernameIcon.widthAnchor.constraint(equalToConstant: 35),
            coinsIcon.widthAnchor.constraint(equalTo: usernameIcon.widthAnchor),
            emailIcon.widthAnchor.constraint(equalTo: usernameIcon.widthAnchor),
            
            realPurchasesButton.heightAnchor.constraint(equalToConstant: 50),
            coinsPurchasesButton.heightAnchor.constraint(equalTo: realPurchasesButton.heightAnchor),
            signOutButton.heightAnchor.constraint(equalTo: realPurchasesButton.heightAnchor)
            
        ])
    }
    
}
