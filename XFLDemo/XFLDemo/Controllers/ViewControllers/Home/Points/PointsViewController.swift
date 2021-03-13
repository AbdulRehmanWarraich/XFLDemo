//
//  PointsViewController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import UIKit

class PointsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PointsViewModel = PointsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.hideDefaultSeprator()
        PointsTableViewCell.registerReusableCell(with: tableView)
        
        viewModel.delegate = self
        viewModel.bootstrap()
    }
}

//MARK: - ViewModelDelegate
extension PointsViewController: PointsViewModelDelegate {
    func willLoadData() {
        self.showActivityIndicator()
    }
    
    func presentTeamsDetails() {
        self.hideActivityIndicator()
        tableView.reloadTableViewData()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension PointsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: PointsTableViewCell = tableView.dequeueReusableCell() {
            let dataObject = viewModel.dataSource[indexPath.row]
            cell.configure(data: dataObject)
            return cell
        }
        
        return UITableViewCell()
    }
}
