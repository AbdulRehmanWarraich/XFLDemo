//
//  LoginViewController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit
import IQKeyboardManagerSwift

class LoginViewController: BaseViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var emailTextField: AppTextField!
    @IBOutlet weak var passwordTextField: AppTextField!
    @IBOutlet weak var loginButton: AppButton!
    @IBOutlet weak var loginTroubleButton: AppButton!
    
    //MARK: - Properties
    var viewModel: LoginViewModel = LoginViewModel()
    
    //MARK: - View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func setupView() {
        super.setupView()
        emailTextField.delegate = self
        passwordTextField.delegate = self

        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.lightGray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.lightGray])

        viewModel.delegate = self
        viewModel.bootstrap()
    }
    
    
    //MARK:- @IBAction / #selector
    @IBAction func loginAction(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let inputErrors = viewModel.validateInputValues()
        if inputErrors.count <= 0 {
            viewModel.login()
        } else {
            sender.horizontalShake()
            self.showErrorAlertWith(message: inputErrors.first?.errorMessage)
        }
    }
    
    @IBAction func loginTroubleAction(_ sender: UIButton) {
        print("To be implemented")
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        if textField == emailTextField {
            viewModel.userEmail = textField.text ?? ""
        } else {
            viewModel.password = textField.text ?? ""
        }
    }
    
    //MARK:- Functions
    private func redirectToHomeScreen() {
        
        if let scene = UIApplication.shared.connectedScenes.first,
           let sceneDelegate : SceneDelegate = scene.delegate as? SceneDelegate,
           let homeViewController: HomeViewController = HomeViewController.instantiateViewControllerFromStoryboard() {
            
            let navigationController = AppNavigationController()
            navigationController.viewControllers = [homeViewController]
            
            sceneDelegate.window?.rootViewController = navigationController
        }
    }
}

//MARK: - LoginModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    
    func willLoadData() {
        self.showActivityIndicator()
    }
    
    func loggedInSuccessfully() {
        self.hideActivityIndicator()
        self.redirectToHomeScreen()
    }
    
    func failedToLogIn(_ error: Error) {
        self.hideActivityIndicator()
        self.showErrorAlertWith(message: error.localizedDescription)
    }
}

// MARK: - UITextFieldDelegate extension
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField == emailTextField) {
            if (viewModel.validateInputValues().contains(where: {$0.type == .email}) == false) {
                passwordTextField.becomeFirstResponder()
                return true
            } else {
                textField.horizontalShake()
                return false
            }
            
        } else if (textField == passwordTextField) {
            if (viewModel.validateInputValues().contains(where: {$0.type == .password}) == false) {
                loginAction(loginButton)
                textField.resignFirstResponder()
                return true
            } else {
                textField.horizontalShake()
                return false
            }
            
        } else {
            textField.resignFirstResponder()
            return true
        }
    }
}
