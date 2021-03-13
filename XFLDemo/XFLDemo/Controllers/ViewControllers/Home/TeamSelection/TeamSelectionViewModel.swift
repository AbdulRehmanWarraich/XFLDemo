//
//  TeamSelectionViewModel.swift
//  XFLDemo
//
//  Created by AbdulRehman on 09/03/2021.
//


import UIKit

typealias XFLTeamSelectionCompletionHandler = (_ selectedTeam:Team) -> ()

class TeamSelectionViewModel: BaseViewModel {
    
    weak var delegate: BaseViewModelDelegate?
    var selectionCompletionBlock: XFLTeamSelectionCompletionHandler?
    
    // MARK:- Properties
    var data : [Team] = []
    
    
    // MARK:- init
    func bootstrap() {
        delegate?.willLoadData()
        
        delegate?.didLoadData()
    }
}
