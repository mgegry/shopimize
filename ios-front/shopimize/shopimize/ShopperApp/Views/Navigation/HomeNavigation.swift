//
//  HomeNavigation.swift
//  shopimize
//
//  Created by Mircea Egry on 15/03/2022.
//

import UIKit

/// Navigation Bar for the home screen ( market screen )

class HomeNavigation: UIView {
    
    let stack: UIStackView = {
        var stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = NavigationConstants.stackSpacing
        return stack
    }()
    
    let title: UILabel = {
        var label = UILabel()
        label.text = "Shopimize"
        label.font = UIFont(name: NavigationConstants.fontName,
                            size: NavigationConstants.fontSize)
        return label
    }()
    
    let filterButton: UIButton = {
        var button = UIButton()
        
        button.setImage(UIImage(systemName: "slider.horizontal.3",
                                withConfiguration: NavigationConstants.buttonIconConfig),
                                for: .normal)
        return button
    }()
    
    let cartButton: UIButton = {
        var button = UIButton()
        
        button.setImage(UIImage(systemName: "cart",
                                withConfiguration: NavigationConstants.buttonIconConfig),
                                for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        stack.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(filterButton)
        stack.addArrangedSubview(cartButton)
        addSubview(stack)
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
