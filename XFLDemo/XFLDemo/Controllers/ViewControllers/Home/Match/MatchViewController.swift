//
//  MatchViewController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 10/03/2021.
//


import UIKit
import UICircularProgressRing

class MatchViewController: BaseViewController {
    
    enum TimerButtonState {
        case start
        case stop
        case pause
        case playing
        case alreadyPlayed
    }
    
    //MARK: - @IBOutlet
    @IBOutlet weak var aTeamContainorView: UIView!
    @IBOutlet weak var aTeamImageView: UIImageView!
    @IBOutlet weak var aTeamNameLabel: UILabel!
    
    @IBOutlet weak var bTeamContainorView: UIView!
    @IBOutlet weak var bTeamImageView: UIImageView!
    @IBOutlet weak var bTeamNameLabel: UILabel!
    
    @IBOutlet weak var aTeamCounter: CounterView!
    @IBOutlet weak var bTeamCounter: CounterView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var progressView: UICircularTimerRing!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var matchStatusLabel: UILabel!
    
    var viewModel: MatchViewModel?
    var currentState: TimerButtonState = .start
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        
        title = "Match"
        
        DispatchQueue.main.async { [weak self] in
            self?.aTeamContainorView.layer.cornerRadius = (self?.aTeamContainorView.frame.height ?? 2)/2
            self?.aTeamContainorView.clipsToBounds = true
            self?.bTeamContainorView.layer.cornerRadius = (self?.bTeamContainorView.frame.height ?? 2)/2
            self?.bTeamContainorView.clipsToBounds = true
            self?.startButton.layer.cornerRadius = 70
        }
        
        self.aTeamNameLabel.text = self.viewModel?.matchDetail?.aTeam?.fullName ?? ""
        self.aTeamImageView.downloaded(url: self.viewModel?.matchDetail?.aTeam?.logoImage ?? "")
        
        self.bTeamNameLabel.text = self.viewModel?.matchDetail?.bTeam?.fullName ?? ""
        self.bTeamImageView.downloaded(url: self.viewModel?.matchDetail?.bTeam?.logoImage ?? "")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.hideDefaultSeprator()
        TeamPlayerNameCell.registerReusableCell(with: tableView)
        
        progressView.font = .semiBold(fontSize: 30)
        progressView.fontColor = .appGray
        progressView.isReverse = true
        var progressValueFormator = UICircularTimerRingFormatter()
        progressValueFormator.style = .positional
        progressView.valueFormatter = progressValueFormator
        
        shadowView.layer.cornerRadius = 70
        shadowView.clipsToBounds = true
        shadowView.backgroundColor = .appWhite
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 4
        
        if(viewModel?.matchDetail?.isPlayed == true) {
            transformControlToState(.alreadyPlayed)
            aTeamCounter.countValue = viewModel?.matchDetail?.aTeamGoal ?? 0
            bTeamCounter.countValue = viewModel?.matchDetail?.bTeamGoal ?? 0
        } else {
            transformControlToState(.start)
        }
        
        viewModel?.delegate = self
        viewModel?.bootstrap()
        
        
    }
    
    //MARK: - @IBAction
    @IBAction func startTimerAction(_ sender: UIButton) {
        
        switch currentState {
        case .start:
            self.initiateTimmer()
            transformControlToState(.playing)
        case .stop:
            viewModel?.storeMatchResult(aTeamGoal: aTeamCounter.countValue, bTeamGoal: bTeamCounter.countValue)
            break
        case .pause:
            transformControlToState(.playing)
        case .playing:
            transformControlToState(.pause)
        case .alreadyPlayed:
            break
        }
    }
    
    //MARK: - Functions
    
    private func initiateTimmer() {
        self.progressView.startTimer(to: 5) { [weak self] state in
            
            switch state {
            
            case .finished:
                self?.transformControlToState(.stop)
                
            case .continued(_):
                break
                
            case .paused(_):
                break
            }
        }
    }
    
    private func transformControlToState(_ state: TimerButtonState) {
        switch state {
        
        case .start:
            
            self.canUpdateGoals(false)
            self.matchStatusLabel.text = "Begin Match"
            
            self.startButton.setTitle("Start", for: .normal)
            self.startButton.backgroundColor = .appGreen
            self.startButton.transform = CGAffineTransform.identity
            transformToState(true) {
                print("Start")
            }
            
        case .stop:
            self.canUpdateGoals(false)
            self.matchStatusLabel.text = "Time up"
            self.progressView.resetTimer()
            
            self.startButton.setTitle("Stop", for: .normal)
            self.startButton.backgroundColor = .appRed
            transformToState(true) {
                print("Stop")
            }
            
        case .pause:
            self.canUpdateGoals(false)
            self.matchStatusLabel.text = "Paused"
            self.progressView.pauseTimer()
            
            self.startButton.setTitle("Resume", for: .normal)
            self.startButton.backgroundColor = .appGray
            transformToState(true) {
                print("Pause")
            }
            break
        case .playing:
            self.canUpdateGoals(true)
            self.matchStatusLabel.text = "Playing"
            
            //Current state is not chande yet, This will represet old value
            if(currentState == .pause) {
                self.progressView.continueTimer()
            }
            
            self.startButton.setTitle("Pause", for: .normal)
            self.startButton.backgroundColor = UIColor.appShadowBlack
            transformToState(false) {
                print("Playing")
            }
            break
            
        case .alreadyPlayed:
            self.canUpdateGoals(false)
            self.matchStatusLabel.text = "Already played"
            
            self.startButton.setTitle("Ended", for: .normal)
            self.startButton.backgroundColor = UIColor.appRed
            self.startButton.isEnabled = false
        }
        
        currentState = state
    }
    
    private func transformToState(_ orignal: Bool, completion: @escaping () -> ()) {
        if orignal {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.startButton.transform = CGAffineTransform.identity
                completion()
            }
        } else {
            self.startButton.setAnchorPoint(CGPoint(x: 0.5, y: 0.915))
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.startButton.transform = CGAffineTransform.init(scaleX: 0.33, y: 0.33)
            } completion: { [weak self] (isCompleted) in
                if(isCompleted) {
                    self?.startButton.layer.anchorPoint = CGPoint(x: 0.5, y: 0.915);
                    completion()
                }
            }
        }
    }
    
    private func canUpdateGoals(_ isEnabled: Bool) {
        aTeamCounter.isEnabled = isEnabled
        bTeamCounter.isEnabled = isEnabled
    }
}

//MARK: - ViewModelDelegate
extension MatchViewController: MatchViewModelDelegate {
    
    func willLoadData() {
        self.showActivityIndicator()
    }
    
    func didLoadData() {
        self.hideActivityIndicator()
    }
    
    func matchResultSavedSuccessfully(_ successMessage: String) {
        self.hideActivityIndicator()
        self.showSuccessAlertWith(message: successMessage, { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        })
    }
    
    func failedToSaveMatchResult(_ error: Error) {
        self.hideActivityIndicator()
        self.showErrorAlertWith(message: error.localizedDescription)
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension MatchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((viewModel?.matchDetail?.aTeam?.players.count ?? 0) == (viewModel?.matchDetail?.bTeam?.players.count ?? 0)) ? viewModel?.matchDetail?.bTeam?.players.count ?? 0 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: TeamPlayerNameCell = tableView.dequeueReusableCell(forIndexPath: indexPath) {
            cell.configure(aTeamPlayerName: viewModel?.matchDetail?.aTeam?.players[indexPath.row].name,
                           bTeamPlayerName: viewModel?.matchDetail?.bTeam?.players[indexPath.row].name,
                           hideSeparator: indexPath.row == 0 ? true : false)
            return cell
        }
        
        return UITableViewCell()
    }
}

