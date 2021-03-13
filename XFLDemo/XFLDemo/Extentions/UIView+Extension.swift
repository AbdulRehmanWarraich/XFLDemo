//
//  UIView+Extension.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit
import AudioToolbox

extension UIView {
    
    func horizontalShake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 6, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 6, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func addShadow(color: UIColor) {
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.6
    }
    
    /**
     Adds description view as sub view to UIView.
     
     - parameter imageName: Image name for description view.
     - parameter description: Text to be displayed in description view.
     
     - returns: void.
     */
    func showDescriptionViewWithImage(_ imageName:String = "no_data",
                                      description: String?,
                                      descriptionColor :UIColor = UIColor.appRed,
                                      descriptionFont :UIFont = UIFont.regular(fontSize: 16),
                                      centerYConstant :CGFloat = -40) {
        
        if let myDescriptionView = self.viewWithTag(NoDataView.tagValue) as? NoDataView {
            
            
            myDescriptionView.setupViewLayoutValues(imageName, description: description, descriptionColor: descriptionColor, descriptionFont: descriptionFont)
        } else {
            
            let myDescriptionView = NoDataView()
            myDescriptionView.setupViewLayout(imageName, description: description, descriptionColor: descriptionColor, descriptionFont: descriptionFont)
            myDescriptionView.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(myDescriptionView)
            self.bringSubviewToFront(myDescriptionView)
            
            myDescriptionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            myDescriptionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
            myDescriptionView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: centerYConstant).isActive = true
            myDescriptionView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        }
    }
    
    ///Hide description view
    func hideDescriptionView() {
        if let myDescriptionView = self.viewWithTag(NoDataView.tagValue) as? NoDataView {
            
            myDescriptionView.isHidden = true
            myDescriptionView.removeFromSuperview()
        }
    }
}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
}
