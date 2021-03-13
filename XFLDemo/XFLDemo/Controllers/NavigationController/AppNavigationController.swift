//
//  AppNavigationController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import UIKit

class AppNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = UIColor.appRed
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appWhite, .font: UIFont.regular(fontSize: 26)]
        navigationBar.tintColor = UIColor.white
    }
    
    //MARK:- Status bar Method
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
