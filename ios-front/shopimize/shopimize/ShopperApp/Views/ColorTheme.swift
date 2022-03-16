//
//  ColorTheme.swift
//  shopimize
//
//  Created by Mircea Egry on 13/03/2022.
//

import Foundation
import UIKit

/// Extension on the UIColor with custom colors so that they can be used anywhere in the app

extension UIColor {
    class var primaryViolet: UIColor {
        return UIColor(red: 137.0 / 255.0, green: 60.0 / 255.0, blue: 205.0 / 255.0, alpha: 1.0)
    }
    
    class var backgroundGrey: UIColor {
        return UIColor(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    }
    
    class var secondaryColor: UIColor {
        return UIColor(red: 234.0 / 255.0, green: 213 / 255, blue: 230.0 / 255.0, alpha: 1.0)
    }
}
