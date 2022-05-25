//
//  ProfileNavigation.swift
//  shopimize
//
//  Created by Mircea Egry on 17/04/2022.
//

import UIKit

/// Navigation Bar for the profile screen
class ProfileNavigation: UIView {

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
        label.text = "My Profile"
        label.font = UIFont(name: NavigationConstants.fontName,
                            size: NavigationConstants.fontSize)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        stack.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        stack.addArrangedSubview(title)
        addSubview(stack)
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
