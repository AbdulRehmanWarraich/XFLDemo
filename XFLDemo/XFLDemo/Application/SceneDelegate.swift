//
//  SceneDelegate.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene,
           let splashVC: SplashViewController = SplashViewController.instantiateViewControllerFromStoryboard(){
            let window = UIWindow(windowScene: windowScene)
            
            window.rootViewController = splashVC
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
