//
//  LoginViewModel.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit

protocol LoginViewModelDelegate: BaseViewModelDelegate {
    func loggedInSuccessfully()
    func failedToLogIn(_ error: Error)
}

class LoginViewModel: BaseViewModel {
    
    enum LoginInputType {
        case email
        case password
    }
    
    weak var delegate: LoginViewModelDelegate?
    
    // MARK:- Properties
    var userEmail: String?
    var password: String?
    
    // MARK:- init
    func bootstrap() {
    }
    
    //MARK: - Network Calls
    func login() {
        
        delegate?.willLoadData()
        
        DataSourceManager.shared.login(email: self.userEmail ?? "",
                                       password: self.password ?? "") { [weak self] (result) in
            
            switch result {
            
            case .success(_):
                self?.delegate?.loggedInSuccessfully()
                
            case .failure(let error):
                self?.delegate?.failedToLogIn(error)
            }
        }
    }
    
    func validateInputValues() -> [ValidatorError<LoginInputType>]{
        var errors: [ValidatorError<LoginInputType>] = []
        if userEmail.isValidEmail() == false {
            errors.append(ValidatorError<LoginInputType>(.email, message: "Please enter a valid email."))
        }
        
        if password.isValidPassword() == false {
            errors.append(ValidatorError<LoginInputType>(.password, message: "Please enter a valid password."))
        }
        return errors
    }
}
