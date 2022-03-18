//
//  AddItemView.swift
//  shopimize
//
//  Created by Mircea Egry on 18/03/2022.
//

import UIKit

class AddItemView: UIView {
    
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
        stackView.distribution = .equalCentering
        stackView.spacing = 16
        return stackView
    }()
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add item"
        
        label.font = UIFont(name: "Arial", size: 30)
        return label
    }()
    
    // Name
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name:"
        label.baselineAdjustment = .alignCenters
        return label
    }()
    
    let name: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Blue Hat"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        return textField
    }()
    
    let nameStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    
    // Description
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description:"
        label.baselineAdjustment = .alignCenters
        return label
    }()
    
    let itemDescription: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.font = UIFont(name: "Arial", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    let descriptionStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    // Price
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Price:"
        label.baselineAdjustment = .alignCenters
        return label
    }()
    
    let price: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "93.9£"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let priceStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        return stack
    }()
    
    // Is active switch
    
    let isActiveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Active for purchase?"
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
    
    // MARK: Initializers
    
    var safeArea = UIEdgeInsets()
    
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
        
        //stackView.addArrangedSubview(pageLabel)
        stackView.addArrangedSubview(nameStack)
        stackView.addArrangedSubview(descriptionStack)
        stackView.addArrangedSubview(priceStack)
        stackView.addArrangedSubview(isActiveStack)
        
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(name)
        
        descriptionStack.addArrangedSubview(descriptionLabel)
        descriptionStack.addArrangedSubview(itemDescription)
        
        priceStack.addArrangedSubview(priceLabel)
        priceStack.addArrangedSubview(price)
        
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
            stackView.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 20),
            
            itemDescription.heightAnchor.constraint(equalToConstant: 100),
            //pageLabel.heightAnchor.constraint(equalToConstant: 1)
            
        ])
    }
    
}
