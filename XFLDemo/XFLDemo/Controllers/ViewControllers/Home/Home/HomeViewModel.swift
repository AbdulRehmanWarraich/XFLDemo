//
//  HomeViewModel.swift
//  XFLDemo
//
//  Created by AbdulRehman on 12/03/2021.
//

import UIKit

protocol HomeViewModelDelegate: BaseViewModelDelegate {
    func loggedOutSuccessfully()
    func failedToLogOut(_ error: Error)
}

class HomeViewModel: BaseViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    // MARK:- init
    func bootstrap() {
    }
    
    //MARK: - Network Calls
    func signOut() {
        delegate?.willLoadData()
        
        DataSourceManager.shared.signOut() { [weak self] (result) in
            switch result {
            
            case .success(_):
                self?.delegate?.loggedOutSuccessfully()
                
            case .failure(let error):
                self?.delegate?.failedToLogOut(error)
            }
        }
    }
}
