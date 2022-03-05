//
//  StartView.swift
//  shopimize
//
//  Created by Mircea Egry on 05/03/2022.
//

import UIKit

class StartView: UIView {
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = CGFloat(FormConstants.stackSpacing)
        return stackView
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemIndigo
        return button
    }()
    
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
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registerButton)
        self.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,
                                            constant: CGFloat(FormConstants.horizontalMarginInset)),
            
            stackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,
                                             constant: CGFloat(-FormConstants.horizontalMarginInset))
        ])
    }

}
