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
        stack.spacing = 15
        return stack
    }()
    
    let title: UILabel = {
        var label = UILabel()
        label.text = "Friends"
        label.font = UIFont(name: "Arial", size: 25)
        return label
    }()
    
    let addFriendButton: UIButton = {
        var button = UIButton()
        
    
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        button.setImage(UIImage(systemName: "person.crop.circle.badge.plus", withConfiguration: config), for: .normal)
        button.setImage(UIImage(systemName: "person.crop.circle.badge.plus.fill", withConfiguration: config), for: .selected)
        return button
    }()

    let friendRequestsButton: UIButton = {
        var button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        button.setImage(UIImage(systemName: "person.crop.circle.badge.questionmark", withConfiguration: config), for: .normal)
        button.setImage(UIImage(systemName: "person.crop.circle.badge.questionmark.fill", withConfiguration: config), for: .selected)
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
