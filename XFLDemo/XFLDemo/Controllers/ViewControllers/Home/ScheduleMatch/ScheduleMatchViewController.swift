//
//  ScheduleMatchViewController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import UIKit

class ScheduleMatchViewController: BaseViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var aTeamContainorView: UIView!
    @IBOutlet weak var aTeamImageView: UIImageView!
    @IBOutlet weak var aTeamNameLabel: UILabel!
    @IBOutlet weak var aTeamTableView: UITableView!
    
    @IBOutlet weak var bTeamContainorView: UIView!
    @IBOutlet weak var bTeamImageView: UIImageView!
    @IBOutlet weak var bTeamNameLabel: UILabel!
    @IBOutlet weak var bTeamTableView: UITableView!
    
    @IBOutlet weak var dateSelectionButton: AppButton!
    
    var viewModel: ScheduleMatchViewModel = ScheduleMatchViewModel()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        title = "Schedule Match"
        
        DispatchQueue.main.async { [weak self] in
            self?.aTeamContainorView.layer.cornerRadius = (self?.aTeamContainorView.frame.height ?? 2)/2
            self?.aTeamContainorView.clipsToBounds = true
            self?.bTeamContainorView.layer.cornerRadius = (self?.bTeamContainorView.frame.height ?? 2)/2
            self?.bTeamContainorView.clipsToBounds = true
        }
        aTeamTableView.backgroundColor = .appRed
        aTeamTableView.layer.cornerRadius = AppConfigs.commonCornerRadiusValue
        aTeamTableView.delegate = self
        aTeamTableView.dataSource = self
        aTeamTableView.hideDefaultSeprator()
        PlayerNameCell.registerReusableCell(with: aTeamTableView)
        
        
        bTeamTableView.backgroundColor = .appLightGray
        bTeamTableView.layer.cornerRadius = AppConfigs.commonCornerRadiusValue
        bTeamTableView.delegate = self
        bTeamTableView.dataSource = self
        bTeamTableView.hideDefaultSeprator()
        PlayerNameCell.registerReusableCell(with: bTeamTableView)
        
        self.bTeamImageView.downloaded(url: "")
        self.aTeamImageView.downloaded(url: "")
        
        viewModel.delegate = self
        viewModel.bootstrap()
        
    }
    
    // MARK: - IBActions
    @IBAction func aTeamSelectionButtonTapped(_ sender: Any) {
        if let teamSelectionVC: TeamSelectionViewController = TeamSelectionViewController.instantiateViewControllerFromStoryboard() {
            
            let viewModelObject = TeamSelectionViewModel()
            viewModelObject.data = viewModel.dataSource.filter({$0.id != self.viewModel.selectedBTeam?.id})
            viewModelObject.selectionCompletionBlock = { [weak self] (selectedTeam) in
                self?.viewModel.selectedATeam = selectedTeam
                self?.reloadTeamAData()
            }
            
            teamSelectionVC.viewModel = viewModelObject
            self.presentPOPUP(teamSelectionVC, animated: true)
        }
    }
    
    @IBAction func bTeamSelectionButtonTapped(_ sender: Any) {
        if let teamSelectionVC: TeamSelectionViewController = TeamSelectionViewController.instantiateViewControllerFromStoryboard() {
            
            let viewModelObject = TeamSelectionViewModel()
            viewModelObject.data = viewModel.dataSource.filter({$0.id != self.viewModel.selectedATeam?.id})
            viewModelObject.selectionCompletionBlock = { [weak self] (selectedTeam) in
                
                self?.viewModel.selectedBTeam = selectedTeam
                self?.reloadTeamBData()
            }
            
            teamSelectionVC.viewModel = viewModelObject
            self.presentPOPUP(teamSelectionVC, animated: true)
        }
    }
    
    
    @IBAction func dateSelectionAction(_ sender: UIButton) {
        
        if let datePickerVC: AppDatePicker = AppDatePicker.instantiateViewControllerFromStoryboard(){
            
            datePickerVC.setDatePicker(currentDate: viewModel.selectedDate ?? Date(),
                                       mode: .dateAndTime,
                                       didSelectDateBlock: { [weak self] (date) in
                                        guard let self = self else {return}
                                        
                                        self.viewModel.updateSelectedDate(date)
                                        
                                       })
            self.presentPOPUP(datePickerVC, animated: true, modalTransitionStyle: .crossDissolve)
        }
    }
    
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        let validationError = viewModel.validateInputValues()
        if validationError.count <= 0 {
            viewModel.scheduleMatch()
        } else {
            self.showErrorAlertWith(message: validationError.first?.errorMessage)
            sender.horizontalShake()
        }
    }
    
    // MARK: - Private Methods
    private func reloadTeamAData() {
        aTeamTableView.backgroundColor = UIColor(hexString: self.viewModel.selectedATeam?.brandColor ?? "")
        self.aTeamNameLabel.text = self.viewModel.selectedATeam?.fullName ?? ""
        self.aTeamImageView.downloaded(url: self.viewModel.selectedATeam?.logoImage ?? "")
        
        self.aTeamTableView.reloadData()
    }
    
    private func reloadTeamBData() {
        bTeamTableView.backgroundColor = UIColor(hexString: self.viewModel.selectedBTeam?.brandColor ?? "")
        self.bTeamNameLabel.text = self.viewModel.selectedBTeam?.fullName ?? ""
        self.bTeamImageView.downloaded(url: self.viewModel.selectedBTeam?.logoImage ?? "")
        
        self.bTeamTableView.reloadData()
    }
}

//MARK: - ViewModelDelegate
extension ScheduleMatchViewController: ScheduleMatchViewModelDelegate {
    func willLoadData() {
        self.showActivityIndicator()
    }
    
    func didLoadData() {
        self.dateSelectionButton.setTitle(self.viewModel.formatedSeletedDateString(), for: .normal)
        self.hideActivityIndicator()
    }
    
    func matchScheduleSuccessfully() {
        self.hideActivityIndicator()
        self.showSuccessAlertWith(message: "Match is scheduled successfully", { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        })
    }
    
    func failedToScheduleMatch(_ error: Error) {
        self.hideActivityIndicator()
        self.showErrorAlertWith(message: error.localizedDescription)
    }
}

//MARK: -  UITableViewDelegate, UITableViewDataSource
extension ScheduleMatchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == aTeamTableView {
            return viewModel.selectedATeam?.players.count ?? 0
        } else {
            return viewModel.selectedBTeam?.players.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: PlayerNameCell = tableView.dequeueReusableCell() {
            
            if tableView == aTeamTableView {
                cell.configure(data: viewModel.selectedATeam?.players[indexPath.row], showSeparator: indexPath.row == 0 ? true : false)
                
            } else {
                cell.configure(data: viewModel.selectedBTeam?.players[indexPath.row], showSeparator: indexPath.row == 0 ? true : false)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
}
