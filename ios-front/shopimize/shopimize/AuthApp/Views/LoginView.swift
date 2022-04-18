//
//  LoginView.swift
//  shopimize
//  
//  Created by Mircea Egry on 04/03/2022.
//

import UIKit

/// Class containing login view design declaration and setup

class LoginView: UIView {
    
    // Declare views as computed properties so they are lazy initilised (initialised only when needed)
    
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
        stackView.spacing = ViewConstants.mainStackSpacing
        return stackView
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email:"
        label.font = UIFont(name: ViewConstants.fontName,
                            size: ViewConstants.smallFontSize)
        label.baselineAdjustment = .alignCenters
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let email: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "example@example.com"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.layer.borderWidth = 1
        textField.addDoneButtonOnKeyboard()
        textField.layer.borderColor = .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        textField.layer.cornerRadius = ViewConstants.formFieldCornerRadius
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        return textField
    }()
    
    let emailStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password:"
        label.font = UIFont(name: ViewConstants.fontName,
                            size: ViewConstants.smallFontSize)
        label.baselineAdjustment = .alignCenters
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let password: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        textField.addDoneButtonOnKeyboard()
        textField.layer.borderColor = .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        textField.layer.cornerRadius = ViewConstants.formFieldCornerRadius
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        return textField
    }()
    
    let passwordStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    /// The login button
    let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.backgroundColor = .gray
        return loginButton
    }()
    
    // Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    
    /// No use of storyboards so the initalizer for them is set to unavailable
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Add the subviews to the view
    private func addViews() {
        self.addSubview(scrollView)
        
        scrollView.addSubview(container)
        
        container.addSubview(stackView)
        
        stackView.addArrangedSubview(emailStack)
        stackView.addArrangedSubview(passwordStack)
        stackView.addArrangedSubview(loginButton)
        
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(email)
        
        passwordStack.addArrangedSubview(passwordLabel)
        passwordStack.addArrangedSubview(password)

    }
    
    /// Setup the constraints for the views
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
            
            emailStack.heightAnchor.constraint(equalToConstant: ViewConstants.formFieldHeight),
            passwordStack.heightAnchor.constraint(equalToConstant: ViewConstants.formFieldHeight),
            
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
