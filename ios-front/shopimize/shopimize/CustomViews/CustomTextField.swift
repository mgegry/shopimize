//
//  CustomTextField.swift
//  shopimize
//
//  Created by Mircea Egry on 23/03/2022.
//

import UIKit

/// Custom text field with padding

class CustomTextField: UITextField {
    let padding = UIEdgeInsets(top: 0,
                               left: ViewConstants.formFieldHoriztonalPadding,
                               bottom: 0,
                               right: ViewConstants.formFieldHoriztonalPadding)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: padding)
    }
}
