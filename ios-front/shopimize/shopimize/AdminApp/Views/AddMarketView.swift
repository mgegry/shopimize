//
//  AddMarketView.swift
//  shopimize
//
//  Created by Mircea Egry on 24/03/2022.
//

import UIKit

class AddMarketView: UIView {
    
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
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add market"
        label.textColor = .systemIndigo
        label.font = UIFont(name: ViewConstants.fontName, size: 30)
        return label
    }()

    // Name
    
    let streetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adress: "
        label.font = UIFont(name: ViewConstants.fontName,
                            size: ViewConstants.smallFontSize)
        label.baselineAdjustment = .alignCenters
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let street: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.placeholder = "80 Hoyle Street"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        textField.layer.cornerRadius = ViewConstants.formFieldCornerRadius
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        return textField
    }()
    
    let streetStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    let postcodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Postcode: "
        label.font = UIFont(name: ViewConstants.fontName,
                            size: ViewConstants.smallFontSize)
        label.baselineAdjustment = .alignCenters
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let postcode: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.placeholder = "S3 7LG"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        textField.layer.cornerRadius = ViewConstants.formFieldCornerRadius
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        return textField
    }()
    
    let postcodeStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "City: "
        label.font = UIFont(name: ViewConstants.fontName,
                            size: ViewConstants.smallFontSize)
        label.baselineAdjustment = .alignCenters
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let city: CustomTextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.placeholder = "Sheffield"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = .init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        textField.layer.cornerRadius = ViewConstants.formFieldCornerRadius
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        return textField
    }()
    
    let cityStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = ViewConstants.formFieldStackSpacing
        return stack
    }()
    
    let storePickerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Related store:"
        label.font = UIFont(name: ViewConstants.fontName,
                            size: ViewConstants.smallFontSize)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    let storePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.setContentHuggingPriority(.defaultLow, for: .vertical)
        return picker
    }()
    
    let storePickerStack: UIStackView = {
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
        label.text = "Is market active?"
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
    
    let addMarketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Store", for: .normal)
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
        stackView.addArrangedSubview(streetStack)
        stackView.addArrangedSubview(postcodeStack)
        stackView.addArrangedSubview(cityStack)
        stackView.addArrangedSubview(storePickerStack)
        stackView.addArrangedSubview(isActiveStack)
        stackView.addArrangedSubview(addMarketButton)
        
        streetStack.addArrangedSubview(streetLabel)
        streetStack.addArrangedSubview(street)
        
        postcodeStack.addArrangedSubview(postcodeLabel)
        postcodeStack.addArrangedSubview(postcode)
        
        cityStack.addArrangedSubview(cityLabel)
        cityStack.addArrangedSubview(city)
        
        storePickerStack.addArrangedSubview(storePickerLabel)
        storePickerStack.addArrangedSubview(storePicker)
        
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
            
            streetStack.heightAnchor.constraint(equalToConstant: ViewConstants.formFieldHeight),
            postcodeStack.heightAnchor.constraint(equalToConstant: ViewConstants.formFieldHeight),
            cityStack.heightAnchor.constraint(equalToConstant: ViewConstants.formFieldHeight),
            
            storePicker.heightAnchor.constraint(equalToConstant: 100),
            
            addMarketButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }

}
