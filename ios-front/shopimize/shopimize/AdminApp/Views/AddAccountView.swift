//
//  AddAccountView.swift
//  shopimize
//
//  Created by Mircea Egry on 23/03/2022.
//

import UIKit

class AddAccountView: UIView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.bounces = true
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
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add your item"
        label.textColor = .systemIndigo
        label.font = UIFont(name: ViewConstants.fontName, size: 30)
        return label
    }()
    
    // Name
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name:"
        label.font = UIFont(name: ViewConstants.fontName,
                            size: ViewConstants.smallFontSize)
        label.baselineAdjustment = .alignCenters
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let name: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Blue Hat"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.layer.borderWidth = 1
        textField.layer.borderColor = .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        textField.layer.cornerRadius = ViewConstants.formFieldCornerRadius
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        return textField
    }()
    
    let nameStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    // Is active switch
    
    let isActiveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Active for purchase?"
        label.font = UIFont(name: ViewConstants.fontName,
                            size: ViewConstants.smallFontSize)
        return label
    }()
    
    let isActiveSwitch: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    let isActiveStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    
    let addImageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Image", for: .normal)
        button.setTitleColor(.systemIndigo, for: .normal)
        button.layer.cornerRadius = ViewConstants.buttonCornerRadius
        button.layer.borderColor = .init(red: 0, green: 0.8, blue: 0.3, alpha: 0.8)
        button.layer.borderWidth = 1
        return button
    }()
    
    let addItemButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Item", for: .normal)
        button.setTitleColor(.systemIndigo, for: .normal)
        button.layer.cornerRadius = ViewConstants.buttonCornerRadius
        button.layer.borderColor = .init(red: 0, green: 0.8, blue: 0.3, alpha: 0.8)
        button.layer.borderWidth = 1
        return button
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        stackView.addArrangedSubview(pageLabel)
        stackView.addArrangedSubview(nameStack)
        stackView.addArrangedSubview(isActiveStack)
        stackView.addArrangedSubview(addImageButton)
        stackView.addArrangedSubview(addItemButton)
        
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(name)
        
        
        isActiveStack.addArrangedSubview(isActiveLabel)
        isActiveStack.addArrangedSubview(isActiveSwitch)
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
            
            nameStack.heightAnchor.constraint(equalToConstant: ViewConstants.formFieldHeight),
            
            addImageButton.heightAnchor.constraint(equalToConstant: 30),
            
            addItemButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}
