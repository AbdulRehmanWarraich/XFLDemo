//
//  FixturesViewController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit

class FixturesViewController: BaseViewController {
    
    @IBOutlet weak var dateSelectionButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FixturesViewModel = FixturesViewModel()
    
    // MARK: - UIViewController Methodss
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.hideDefaultSeprator()
        
        viewModel.delegate = self
        viewModel.bootstrap()
    }
    
    // MARK: - @IBAction
    @IBAction func dateSelectionAction(_ sender: UIButton) {
        
        if let datePickerVC : AppDatePicker = AppDatePicker.instantiateViewControllerFromStoryboard(){
            
            datePickerVC.setDatePicker(currentDate: viewModel.selectedDate,
                                       didSelectDateBlock: { [weak self] (date) in
                                        guard let self = self else {return}
                                        
                                        self.viewModel.updateSelectedDate(date)
                                        
                                       })
            self.presentPOPUP(datePickerVC, animated: true, modalTransitionStyle: .crossDissolve)
            
        }
    }
}

//MARK: - ViewModelDelegate
extension FixturesViewController: FixturesViewModelDelegate {
    
    func willLoadData() {
        self.showActivityIndicator()
    }
    
    func presentMatchDetails() {
        self.hideActivityIndicator()
        self.dateSelectionButton.setTitle(self.viewModel.formatedSeletedDateString(date: viewModel.selectedDate), for: .normal)
        tableView.reloadTableViewData()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension FixturesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: FixturesTableViewCell = tableView.dequeueReusableCell() {
            let dataAtIndex = viewModel.filteredDataSource[indexPath.row]
            
            cell.configure(data: dataAtIndex,
                           time: self.viewModel.formatedSeletedDateString(date:dataAtIndex.datestamp, format: DateFormates.kTime))
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let matchVC: MatchViewController = MatchViewController.instantiateViewControllerFromStoryboard() {
            let matchDetails = viewModel.filteredDataSource[indexPath.row]
            matchVC.viewModel = MatchViewModel(matchDetails)
            
            self.navigationController?.pushViewController(matchVC, animated: true)
        }
    }
}
