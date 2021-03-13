//
//  PointsViewModel.swift
//  XFLDemo
//
//  Created by AbdulRehman on 08/03/2021.
//

import UIKit

protocol PointsViewModelDelegate: BaseViewModelDelegate {
    func presentTeamsDetails()
}

class PointsViewModel: BaseViewModel {
    
    weak var delegate: PointsViewModelDelegate?
    
    // MARK:- Properties
    var dataSource : [Team] = []
    
    let dateFormatter = DateFormatter()
    var selectedDate = Date()
    
    // MARK:- init
    func bootstrap() {
        delegate?.willLoadData()
        
        DataSourceManager.shared.fetchsTeams { [weak self] (matches) in
            guard let self = self else {return}
            
            self.dataSource = matches
            self.delegate?.presentTeamsDetails()
        }
    }
}
