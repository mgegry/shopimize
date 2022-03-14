//
//  RegisterView.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import UIKit

/// Class containing the register view screen design and setup

class RegisterView: UIView {
    
    // Declare views as computed properties so they are lazy initilised (initialised only when needed)
    
    /// Stack view holding the register form fields
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = CGFloat(FormConstants.stackSpacing)
        return stackView
    }()
    
    /// Declaration of email text field
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email address"
        return textField
    }()
    
    /// Declaration of password text field
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        return textField
    }()
    
    /// Declaration of password confirm text field
    var passwordConfTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.placeholder = "Confirm password"
        return textField
    }()
    
    /// Declaration of username text field
    var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.borderStyle = .roundedRect
        textField.placeholder = "Your username"
        return textField
    }()
    
    /// Declaration of first name text field
    var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.borderStyle = .roundedRect
        textField.placeholder = "First name"
        return textField
    }()
    
    /// Declaration of last name text field
    var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.borderStyle = .roundedRect
        textField.placeholder = "Last name"
        return textField
    }()
    
    /// Declaration of login button
    var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .gray
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }
    
    /// No use of storyboards so the initializer for storyboards is set to unavailable
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Add subviews to their main views
    private func addViews() {
        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordConfTextField)
        stackView.addArrangedSubview(registerButton)
        
        self.addSubview(stackView)
    }
    
    /// Setup views constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                                              constant: CGFloat(FormConstants.bottomMarginInset)),
            stackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,
                                            constant: CGFloat(FormConstants.horizontalMarginInset)),
            stackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,
                                             constant: CGFloat(-FormConstants.horizontalMarginInset)),
            firstNameTextField.heightAnchor.constraint(equalToConstant: CGFloat(FormConstants.textFieldHeight)),
            lastNameTextField.heightAnchor.constraint(equalToConstant: CGFloat(FormConstants.textFieldHeight)),
            passwordTextField.heightAnchor.constraint(equalToConstant: CGFloat(FormConstants.textFieldHeight)),
            passwordConfTextField.heightAnchor.constraint(equalToConstant: CGFloat(FormConstants.textFieldHeight)),
            usernameTextField.heightAnchor.constraint(equalToConstant: CGFloat(FormConstants.textFieldHeight)),
            emailTextField.heightAnchor.constraint(equalToConstant: CGFloat(FormConstants.textFieldHeight)),
            registerButton.heightAnchor.constraint(equalToConstant: CGFloat(FormConstants.textFieldHeight)),
        ])
    }
    
}
