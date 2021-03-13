//
//  HomeViewController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit

class HomeViewController: BaseViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var pageController: CustomPageController!
    @IBOutlet weak var addMatchButton: UIButton!
    
    var viewModel: HomeViewModel = HomeViewModel()
    var childViewContollers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        
        addMatchButton.layer.cornerRadius = 30
        addMatchButton.layer.masksToBounds = false
        addMatchButton.layer.shadowColor = UIColor.black.cgColor
        addMatchButton.layer.shadowOpacity = 0.6
        addMatchButton.layer.shadowOffset = .zero
        addMatchButton.layer.shadowRadius = 8
        
        if let fixtureViewController: FixturesViewController = FixturesViewController.instantiateViewControllerFromStoryboard() {
            fixtureViewController.viewModel = FixturesViewModel()
            childViewContollers.append(fixtureViewController)
        }
        if let pointsViewController: PointsViewController = PointsViewController.instantiateViewControllerFromStoryboard() {
            pointsViewController.viewModel = PointsViewModel()
            childViewContollers.append(pointsViewController)
        }
        
        pageController.delegate = self
        pageController.setupViewLayout()
        
        viewModel.delegate = self
        viewModel.bootstrap()
    }
    
    // MARK: - IBActions
    @IBAction func logoutButtonAction(_ sender: UIBarButtonItem) {
        self.showConfirmationAlert(title: "Logout", message: "Are you sure you want to logout.", okTitle: "Yes", cancelTitle: "No", okActionBlock:  { [weak self] in
            self?.viewModel.signOut()
        })
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        if let scheduleMatchVC: ScheduleMatchViewController = ScheduleMatchViewController.instantiateViewControllerFromStoryboard() {
            
            self.navigationController?.pushViewController(scheduleMatchVC, animated: true)
        }
    }
    
    // MARK: - Helper Functions
    private func redirectToLoginScreen() {
        if let scene = UIApplication.shared.connectedScenes.first,
           let sceneDelegate : SceneDelegate = scene.delegate as? SceneDelegate,
           let window = sceneDelegate.window,
           let loginVC: LoginViewController = LoginViewController.instantiateViewControllerFromStoryboard() {
            
            window.rootViewController = loginVC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {})
        }
    }
}

//MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    
    func willLoadData() {
        self.showActivityIndicator()
    }
    func loggedOutSuccessfully() {
        self.hideActivityIndicator()
        self.redirectToLoginScreen()
    }
    
    func failedToLogOut(_ error: Error) {
        self.hideActivityIndicator()
        self.showErrorAlertWith(message: error.localizedDescription)
    }
}

// MARK: - CustomPageControllerDelegate
extension HomeViewController: CustomPageControllerDelegate {
    func numberOfViewControllers() -> Int {
        return childViewContollers.count
    }
    
    func titleOfViewController(at position: Int) -> String? {
        return position == 0 ? "Fixtures" : "Points"
    }
    
    func childViewControllers() -> [UIViewController] {
        return childViewContollers
    }
    
    func parentController() -> UIViewController {
        return self
    }
}
