//
//  FixturesViewModel.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import UIKit

protocol FixturesViewModelDelegate: BaseViewModelDelegate {
    func presentMatchDetails()
}

class FixturesViewModel: BaseViewModel {
    
    weak var delegate: FixturesViewModelDelegate?
    
    // MARK:- Properties
    var dataSource: [Match] = []
    var filteredDataSource: [Match] = []
    
    let dateFormatter = DateFormatter()
    var selectedDate = Date()
    
    // MARK:- init
    func bootstrap() {
        delegate?.willLoadData()
        
        DataSourceManager.shared.fetchsMatchesSchedules { [weak self] (matches) in
            guard let self = self else {return}
            
            self.dataSource = matches
            self.filteredDataSource = matches
            self.dateFormatter.dateFormat = DateFormates.dateStandard
            self.filteredDataSource = matches.filter({
                if let aDate = $0.datestamp,
                   self.dateFormatter.string(from: aDate) == self.dateFormatter.string(from: self.selectedDate) {
                    return true
                } else {
                    return false
                }
            })
            self.filteredDataSource = self.filteredDataSource.sorted { (aMatch, bMatch) -> Bool in
                if let aDate = aMatch.datestamp,
                   let bDate = bMatch.datestamp {
                    return aDate < bDate
                }
                return false
            }
            self.delegate?.presentMatchDetails()
        }
    }
    
    
    //MARK: - Helper functions
    func formatedSeletedDateString(date: Date?, format: String = DateFormates.kDateTime) -> String {
        
        dateFormatter.dateFormat = format
        
        let formatedDate: String = dateFormatter.string(from: date ?? Date())
        
        return formatedDate
    }
    
    func updateSelectedDate(_ date: Date) {
        self.delegate?.willLoadData()
        self.selectedDate = date
        
        self.filteredDataSource = []
        self.dateFormatter.dateFormat = DateFormates.dateStandard
        self.filteredDataSource = dataSource.filter({
            if let aDate = $0.datestamp,
               self.dateFormatter.string(from: aDate) == self.dateFormatter.string(from: self.selectedDate) {
                return true
            } else {
                return false
            }
        })
        
        self.delegate?.presentMatchDetails()
    }
}
