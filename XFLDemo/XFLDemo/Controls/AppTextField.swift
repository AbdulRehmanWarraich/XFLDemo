//
//  AppTextField.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit

class AppTextField: UITextField {
    
    lazy var bottomLine = CALayer()
    
    @IBInspectable var bottomBoaderHeight: CGFloat = 1.0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var bottomBoaderColor: UIColor = UIColor.appLightGray {
        didSet {
            setup()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup() {
        borderStyle = .none
        
        bottomLine.frame = CGRect(x: 0,
                                  y: self.frame.size.height - bottomBoaderHeight,
                                  width: self.frame.size.width,
                                  height: bottomBoaderHeight)
        bottomLine.backgroundColor = bottomBoaderColor.cgColor

        layer.addSublayer(bottomLine)
    }
}
