//
//  LoginView.swift
//  shopimize
//  
//  Created by Mircea Egry on 04/03/2022.
//

import UIKit

class LoginView: UIView {
    
    // Declare views as computed properties so they are lazy initilised (initialised only when needed)
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = CGFloat(FormConstants.stackSpacing)
        stackView.distribution = .fill
        return stackView
    }()
    
    var emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Enter your email..."
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        return emailTextField
    }()
    
    var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password..."
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        return passwordTextField
    }()
    
    let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.cornerRadius = 20
        loginButton.backgroundColor = .gray
        return loginButton
    }()
    
    // Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        setupConstraints()
    }
    
    // Methods
    private func addViews() {
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        self.addSubview(stackView)

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                              constant: CGFloat(FormConstants.bottomMarginInset)),
            
            stackView.leftAnchor.constraint(equalTo:self.safeAreaLayoutGuide.leftAnchor,
                                            constant: CGFloat(FormConstants.horizontalMarginInset)),
            
            stackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,
                                             constant: CGFloat(-FormConstants.horizontalMarginInset)),
            
            emailTextField.heightAnchor.constraint(equalToConstant: CGFloat(FormConstants.textFieldHeight)),
            passwordTextField.heightAnchor.constraint(equalToConstant: CGFloat(FormConstants.textFieldHeight)),
            loginButton.heightAnchor.constraint(equalToConstant: CGFloat(FormConstants.textFieldHeight)),
        ])
    }
    
}
