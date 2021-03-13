//
//  MatchViewModel.swift
//  XFLDemo
//
//  Created by AbdulRehman on 10/03/2021.
//

import UIKit

protocol MatchViewModelDelegate: BaseViewModelDelegate {
    func matchResultSavedSuccessfully(_ successMessage: String)
    func failedToSaveMatchResult(_ error: Error)
}

class MatchViewModel: BaseViewModel {
    
    weak var delegate: MatchViewModelDelegate?
    
    // MARK:- Properties
    var matchDetail: Match?
    
    // MARK:- init
    init(_ match: Match?) {
        matchDetail = match
    }
    
    func bootstrap() {
    }
    
    func storeMatchResult(aTeamGoal: Int, bTeamGoal: Int) {
        
        self.delegate?.willLoadData()
        
        guard var matchObject = matchDetail,
              let aTeamObject = matchObject.aTeam,
              let bTeamObject = matchObject.bTeam
        else {
            self.delegate?.failedToSaveMatchResult(NSError.create(reason: "Team data loading failed", description: "Unexpected error occurred during match result storage."))
            return
        }
        // Set number og goals
        matchObject.aTeamGoal = aTeamGoal
        matchObject.bTeamGoal = bTeamGoal
        
        if aTeamGoal == bTeamGoal { //Draw
            
            storeMatchResult(match: matchObject, winnerTeam: aTeamObject, losserTeam: bTeamObject, isDraw: true)
        } else if aTeamGoal > bTeamGoal { // A team Won
            
            storeMatchResult(match: matchObject, winnerTeam: aTeamObject, losserTeam: bTeamObject)
        } else if aTeamGoal < bTeamGoal { // B team Won
            
            storeMatchResult(match: matchObject, winnerTeam: bTeamObject, losserTeam: aTeamObject)
        }
    }
    
    private func storeMatchResult(match: Match, winnerTeam: Team, losserTeam: Team, isDraw: Bool = false) {
        
        DataSourceManager.shared.updateMatch(match: match) { [weak self] (result) in
            
            switch result {
            
            case .success(_):
                
                DataSourceManager.shared.storeMatchResult(winnerTeam: winnerTeam, losserTeam: losserTeam, isDraw: isDraw) { [weak self] (result) in
                    
                    switch result {
                    
                    case .success(_):
                        
                        self?.delegate?.matchResultSavedSuccessfully(isDraw ? "Congratulations! Match was a draw between \(winnerTeam.fullName) and \(losserTeam.fullName)" : "Congratulations! \(winnerTeam.fullName) Won")
                        
                    case .failure(let error):
                        self?.delegate?.failedToSaveMatchResult(error)
                    }
                }
                
            case .failure(let error):
                self?.delegate?.failedToSaveMatchResult(error)
            }
        }
    }
}
