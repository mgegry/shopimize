//
//  Cart.swift
//  shopimize
//
//  Created by Mircea Egry on 16/03/2022.
//

import UIKit

/// Class containing cart screen design and layout constraints

class CartView: UIView {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundGrey
    }
    
    /// No use of storyboards so initializer is set to unavailable
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
