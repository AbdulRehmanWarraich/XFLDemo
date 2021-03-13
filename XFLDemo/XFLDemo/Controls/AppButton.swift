//
//  AppButton.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit

class AppButton: UIButton {
    
    enum ButtonLayoutType: Int {
        case whiteTextRedBackground = 1
        case redTextWhiteBackground = 2
        case other = 0
    }
    
    var buttonLayoutTypeInfo :ButtonLayoutType = .other
    
    @IBInspectable var buttonLayoutType :Int {
        get {
            return self.buttonLayoutTypeInfo.rawValue
            
        } set( labelTypeIndex ) {
            
            self.buttonLayoutTypeInfo = ButtonLayoutType(rawValue: labelTypeIndex) ?? .other
            adjustsButtonLayout()
        }
    }
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        adjustsButtonLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        adjustsButtonLayout()
    }
    
    //MARK: - Functions
    
    func adjustsButtonLayout() {
        
        switch buttonLayoutTypeInfo {
        case .whiteTextRedBackground:
            
            setButtonLayoutWith(font: UIFont.semiBold(fontSize: 18),
                                titleColor: UIColor.appWhite,
                                cornerRadious: AppConfigs.commonCornerRadiusValue,
                                bcakGroundColor: UIColor.appRed)
            self.addShadow(color: UIColor.appShadowBlack)
        case .redTextWhiteBackground:
            
            setButtonLayoutWith(font: UIFont.semiBold(fontSize: 18),
                                titleColor: UIColor.appRed,
                                cornerRadious: AppConfigs.commonCornerRadiusValue,
                                bcakGroundColor: UIColor.appWhite)
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.appRed.cgColor
            self.addShadow(color: UIColor.appShadowBlack)
            
        default:
            break
        }
    }
    
    func setButtonLayoutWith(font: UIFont,
                             titleColor :UIColor,
                             cornerRadious :CGFloat,
                             bcakGroundColor :UIColor) {
        
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: UIControl.State.normal)
        
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        layer.cornerRadius = cornerRadious
        
        self.backgroundColor = bcakGroundColor
    }
}

