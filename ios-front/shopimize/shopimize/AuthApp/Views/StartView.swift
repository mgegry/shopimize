//
//  StartView.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import UIKit

/// Class containing the start view of the app design the setup

class StartView: UIView {
    
    // Declare views as computed properties so they are lazy initilised (initialised only when needed)
    
    /// Stack view for the start layout
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = CGFloat(FormConstants.stackSpacing)
        return stackView
    }()
    
    /// Declaration of ogin button
    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .primaryViolet
        return button
    }()
    
    /// Declaration of register button
    var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .gray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    /// No use of storyboards so the initalizer for them is set to unavailable
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Add the subiews to the main view
    private func addSubviews() {
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registerButton)
        self.addSubview(stackView)
    }
    
    /// Setup the views constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,
                                            constant: CGFloat(FormConstants.horizontalMarginInset)),
            
            stackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,
                                             constant: CGFloat(-FormConstants.horizontalMarginInset)),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

}
