//
//  UIFont+Extension.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit

extension UIFont {
    
    /**
     Returns a GillSans Regular font with custom size.
     
     - parameter fontSize: Font size.
     
     - returns: UIFont.
     */
    class func regular(fontSize: Float) -> UIFont {
        return UIFont(name: "GillSans", size: CGFloat(fontSize)) ?? UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
    
    /**
     Returns a GillSans SemiBold  font with custom size.
     
     - parameter fontSize: Font size.
     
     - returns: UIFont.
     */
    class func semiBold(fontSize: Float) -> UIFont {
        return UIFont(name: "GillSans-SemiBold", size: CGFloat(fontSize)) ?? UIFont.systemFont(ofSize: CGFloat(fontSize), weight: UIFont.Weight.bold)
    }
    
    /**
     Returns a GillSans Bold font with custom size.
     
     - parameter fontSize: Font size.
     
     - returns: UIFont.
     */
    class func bold(fontSize: Float) -> UIFont {
        return UIFont(name: "GillSans-Bold", size: CGFloat(fontSize)) ?? UIFont.systemFont(ofSize: CGFloat(fontSize), weight: UIFont.Weight.bold)
    }
    
    /**
     Print all available fonts
     */
    class func printAllFonts() {
        for family in UIFont.familyNames {
            print("Font family Name: \(family)")
            print("-------------------------------")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   \(name)")
            }
            print("-------------------------------")
        }
    }
}
