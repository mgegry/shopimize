//
//  IndividualItemView.swift
//  shopimize
//
//  Created by Mircea Egry on 03/05/2022.
//

import UIKit

class IndividualItemView: UIView {
    
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
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    
    let imageStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    let name: CustomLabel = {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let itemDescription: CustomLabel = {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.numberOfLines = 3
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
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
        button.setTitle("Add to cart", for: .normal)
        button.setTitleColor(.backgroundGrey, for: .normal)
        button.setTitleColor(.systemGray, for: .highlighted)
        button.backgroundColor = .primaryViolet
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
        
        stackView.addArrangedSubview(imageStackView)
        stackView.addArrangedSubview(headerStackView)
        stackView.addArrangedSubview(bodyStackView)
        
        headerStackView.addArrangedSubview(name)
        headerStackView.addArrangedSubview(itemDescription)
        headerStackView.addArrangedSubview(coins)

        bodyStackView.addArrangedSubview(realPurchasesButton)
        
        imageStackView.addArrangedSubview(image)
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
            
            image.heightAnchor.constraint(equalToConstant: 300),
            
//            usernameStackView.leftAnchor.constraint(equalTo: headerStackView.leftAnchor, constant: 10),
//            coinsStackView.leftAnchor.constraint(equalTo: headerStackView.leftAnchor, constant: 10),
//            emailIcon.leftAnchor.constraint(equalTo: emailStackView.leftAnchor, constant: 10),
            
            name.heightAnchor.constraint(equalToConstant: 50),
            itemDescription.heightAnchor.constraint(equalToConstant: 100),
            coins.heightAnchor.constraint(equalToConstant: 50),
            
            realPurchasesButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    
}
