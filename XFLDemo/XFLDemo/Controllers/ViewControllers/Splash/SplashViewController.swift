//
//  SplashViewController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 13/03/2021.
//

import UIKit

class SplashViewController: BaseViewController {
    
    //MARK: - View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Start Firebase config
        DataSourceManager.shared.configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            if DataSourceManager.shared.isLoggedIn{
                self?.redirectToHomeScreen()
            } else {
                self?.redirectLoginScreen()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //MARK:- Functions
    private func redirectToHomeScreen() {
        
        if let scene = UIApplication.shared.connectedScenes.first,
           let sceneDelegate : SceneDelegate = scene.delegate as? SceneDelegate,
           let window = sceneDelegate.window,
           let homeVC: HomeViewController = HomeViewController.instantiateViewControllerFromStoryboard() {
            
            let navigationController = AppNavigationController()
            navigationController.viewControllers = [homeVC]
            
            window.rootViewController = navigationController
            
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {})
        }
    }
    
    private func redirectLoginScreen() {
        if let scene = UIApplication.shared.connectedScenes.first,
           let sceneDelegate : SceneDelegate = scene.delegate as? SceneDelegate,
           let window = sceneDelegate.window,
           let loginVC: LoginViewController = LoginViewController.instantiateViewControllerFromStoryboard() {
            
            window.rootViewController = loginVC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {})
        }
    }
}
