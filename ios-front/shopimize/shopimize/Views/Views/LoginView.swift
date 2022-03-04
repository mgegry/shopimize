//
//  LoginView.swift
//  shopimize
//
//  Created by Mircea Egry on 04/03/2022.
//

import UIKit

class LoginView: UIView {
    
    // Declare views as computed properties so they are lazy initilised
    
    var testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Testing"
        return label
    }()
    
    var testButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap me", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViews()
        setupConstraints()
    }
    
    // Methods
    
    private func loadViews() {
        self.addSubview(testLabel)
        self.addSubview(testButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            testLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            testLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            testButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}
