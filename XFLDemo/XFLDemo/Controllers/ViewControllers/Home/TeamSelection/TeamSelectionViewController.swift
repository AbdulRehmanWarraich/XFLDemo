//
//  TeamSelectionViewController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import UIKit

class TeamSelectionViewController: BaseViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: -
    var viewModel: TeamSelectionViewModel?
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupView() {
        super.setupView()
        viewModel?.delegate = self
        self.view.backgroundColor = UIColor.appShadowBlack.withAlphaComponent(0.5)
        
        myContentView.layer.cornerRadius = AppConfigs.commonCornerRadiusValue
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.hideDefaultSeprator()
        TeamSelectionCell.registerReusableCell(with: tableView)
        
        viewModel?.bootstrap()
    }
    
    //MARK: - Functions
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == self.view {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}


//MARK: - ViewModelDelegate
extension TeamSelectionViewController: BaseViewModelDelegate {
    func willLoadData() {
    }
    
    func didLoadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension TeamSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: TeamSelectionCell = tableView.dequeueReusableCell(),
           let dataObject = viewModel?.data[indexPath.row] {
            cell.configure(data: dataObject)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataObject = viewModel?.data[indexPath.row] else { return }
        viewModel?.selectionCompletionBlock?(dataObject)
        self.dismiss(animated: true, completion: nil)
    }
}
