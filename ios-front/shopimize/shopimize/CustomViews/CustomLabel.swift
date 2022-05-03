//
//  CustomLabel.swift
//  shopimize
//
//  Created by Mircea Egry on 17/04/2022.
//

import UIKit

class CustomLabel: UILabel {
          
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 8 + 8,
                      height: size.height + 0 + 0)
    }
}
