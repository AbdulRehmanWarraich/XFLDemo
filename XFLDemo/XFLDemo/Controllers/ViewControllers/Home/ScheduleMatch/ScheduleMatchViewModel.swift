//
//  ScheduleMatchViewModel.swift
//  XFLDemo
//
//  Created by AbdulRehman on 09/03/2021.
//

import UIKit

protocol ScheduleMatchViewModelDelegate: BaseViewModelDelegate {
    func matchScheduleSuccessfully()
    func failedToScheduleMatch(_ error: Error)
}

class ScheduleMatchViewModel: BaseViewModel {
    
    enum ScheduleMatchType {
        case aTeam
        case bTeam
        case matchDate
    }
    
    weak var delegate: ScheduleMatchViewModelDelegate?
    
    // MARK:- Properties
    var dataSource : [Team] = []
    
    var selectedATeam: Team?
    var selectedBTeam: Team?
    
    let dateFormatter = DateFormatter()
    var selectedDate: Date?
    
    // MARK:- init
    func bootstrap() {
        delegate?.willLoadData()
        
        DataSourceManager.shared.fetchsTeamsOnce { [weak self] (teams) in
            guard let self = self else {return}
            
            self.dataSource = teams
            self.delegate?.didLoadData()
        }
    }
    
    func scheduleMatch() {
        delegate?.willLoadData()
        guard let aTeamObject = self.selectedATeam,
              let bTeamObject = self.selectedBTeam,
              selectedDate != nil,
              validateInputValues().count <= 0
        else {
            self.delegate?.failedToScheduleMatch(NSError.create(reason: "Team data loading failed", description: "Unexpected error occurred during scheduling match."))
            return
        }
        let dateString = self.formatedSeletedDateString(dateFormate: DateFormates.apiStandard)
        
        DataSourceManager.shared.scheduleMatch(dateStamp: dateString, aTeam: aTeamObject, bTeam: bTeamObject, completion: { [weak self] (result) in
            
            switch result {
            
            case .success(_):
                self?.delegate?.matchScheduleSuccessfully()
                
            case .failure(let error):
                self?.delegate?.failedToScheduleMatch(error)
            }
        })
    }
    
    //MARK: - Helper functions
    
    func updateSelectedDate(_ date: Date) {
        selectedDate = date
        self.delegate?.didLoadData()
    }
    
    func validateInputValues() -> [ValidatorError<ScheduleMatchType>]{
        var errors: [ValidatorError<ScheduleMatchType>] = []
        
        if self.selectedATeam == nil {
            errors.append(ValidatorError<ScheduleMatchType>(.aTeam, message: "Please select both teams to schedule match."))
        }
        
        if self.selectedBTeam == nil {
            errors.append(ValidatorError<ScheduleMatchType>(.bTeam, message: "Please select both teams to schedule match."))
        }
        
        if self.selectedDate == nil {
            errors.append(ValidatorError<ScheduleMatchType>(.bTeam, message: "Please select date and time to schedule match."))
        }
        
        return errors
    }
    
    func formatedSeletedDateString(dateFormate: String = DateFormates.kDateAndTime) -> String {
        
        dateFormatter.dateFormat = dateFormate
        guard let selectedDateObject = selectedDate else { return "Select Date"}
        
        let formatedDate: String = dateFormatter.string(from: selectedDateObject)
        
        return formatedDate
    }
}

