//
//  UIColor+Extension.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit

extension UIColor {
    
    class var appWhite: UIColor {
        return UIColor(named: "appWhite") ?? UIColor.white
    }
    
    class var appShadowBlack: UIColor {
        return UIColor(named: "appShadowBlack") ?? UIColor.black
    }
    
    class var appRed: UIColor {
        return UIColor(named: "appRed") ?? UIColor.red
    }
    
    class var appGray: UIColor {
        return UIColor(named: "appGray") ?? UIColor.gray
    }
    
    class var appLightGray: UIColor {
        return UIColor(named: "appLightGray") ?? UIColor.lightGray
    }
    
    class var viewControllerBackground: UIColor {
        return UIColor(named: "viewControllerBackground") ?? UIColor.white
    }
    
    class var appGreen: UIColor {
        return UIColor(named: "appGreen") ?? UIColor.white
    }
    
}

extension UIColor {
    /// Create color from RGB
    convenience init(absoluteRed: Int, green: Int, blue: Int) {
        self.init(
            absoluteRed: absoluteRed,
            green: green,
            blue: blue,
            alpha: 1.0
        )
    }
    
    /// Create color from RGBA
    convenience init(absoluteRed: Int, green: Int, blue: Int, alpha: CGFloat) {
        let normalizedRed = CGFloat(absoluteRed) / 255
        let normalizedGreen = CGFloat(green) / 255
        let normalizedBlue = CGFloat(blue) / 255
        
        self.init(
            red: normalizedRed,
            green: normalizedGreen,
            blue: normalizedBlue,
            alpha: alpha
        )
    }
    
    // Color from HEX-Value
    convenience init(hexValue:Int) {
        self.init(
            absoluteRed: (hexValue >> 16) & 0xff,
            green: (hexValue >> 8) & 0xff,
            blue: hexValue & 0xff
        )
    }
    
    // Color from HEX-String
    convenience init(hexString:String) {
        var normalizedHexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (normalizedHexString.hasPrefix("#")) {
            normalizedHexString.remove(at: normalizedHexString.startIndex)
        }
        
        // Convert to hexadecimal integer
        var hexValue:UInt32 = 0
        Scanner(string: normalizedHexString).scanHexInt32(&hexValue)
        
        self.init(
            hexValue:Int(hexValue)
        )
    }
}
