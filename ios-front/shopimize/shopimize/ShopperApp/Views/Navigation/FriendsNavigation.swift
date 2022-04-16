//
//  FriendsNavigation.swift
//  shopimize
//
//  Created by Mircea Egry on 16/04/2022.
//

import UIKit

class FriendsNavigation: UIView {

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
        label.text = "Friends"
        label.font = UIFont(name: NavigationConstants.fontName,
                            size: NavigationConstants.fontSize)
        return label
    }()
    
    let addFriendButton: UIButton = {
        var button = UIButton()
        
        button.setImage(UIImage(systemName: "person.crop.circle.badge.plus",
                                withConfiguration: NavigationConstants.buttonIconConfig),
                                for: .normal)
        
        button.setImage(UIImage(systemName: "person.crop.circle.badge.plus.fill",
                                withConfiguration: NavigationConstants.buttonIconConfig),
                                for: .selected)
        return button
    }()

    let friendRequestsButton: UIButton = {
        var button = UIButton()
        
        button.setImage(UIImage(systemName: "person.crop.circle.badge.questionmark",
                                withConfiguration: NavigationConstants.buttonIconConfig),
                                for: .normal)
        
        button.setImage(UIImage(systemName: "person.crop.circle.badge.questionmark.fill",
                                withConfiguration: NavigationConstants.buttonIconConfig),
                                for: .selected)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        stack.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(addFriendButton)
        stack.addArrangedSubview(friendRequestsButton)
        addSubview(stack)
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
