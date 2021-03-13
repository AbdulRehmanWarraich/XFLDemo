//
//  ActivityIndicator+UIViewController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import UIKit

//MARK:- ActivityIndicator
extension UIViewController {
    
    func showActivityIndicator() {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate : SceneDelegate = scene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
            return
        }
        let containorView = UIView()
        containorView.translatesAutoresizingMaskIntoConstraints = false
        containorView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        containorView.tag = 87654321
        window.addSubview(containorView)
        window.bringSubviewToFront(containorView)
        
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = AppConfigs.commonCornerRadiusValue
        contentView.translatesAutoresizingMaskIntoConstraints = false
        containorView.addSubview(contentView)
        window.bringSubviewToFront(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: containorView.centerXAnchor, constant: 0).isActive = true
        contentView.centerYAnchor.constraint(equalTo: containorView.centerYAnchor, constant: 0).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor.appRed
        activityIndicator.startAnimating()
        activityIndicator.center = contentView.center
        
        
        contentView.addSubview(activityIndicator)
        contentView.bringSubviewToFront(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: window.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: window.centerYAnchor, constant: 0).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        containorView.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 0).isActive = true
        containorView.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: 0).isActive = true
        containorView.topAnchor.constraint(equalTo: window.topAnchor, constant: 0).isActive = true
        containorView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func hideActivityIndicator() {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate : SceneDelegate = scene.delegate as? SceneDelegate,
              let window = sceneDelegate.window,
              let activityView = window.viewWithTag(87654321) else {
            return
        }
        activityView.removeFromSuperview()
    }
}
