//
//  PointsTableViewCell.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//


import UIKit

class PointsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var wonValueLabel: UILabel!
    @IBOutlet weak var drawValueLabel: UILabel!
    @IBOutlet weak var lossLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        containerView.layer.borderColor = UIColor.appLightGray.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = AppConfigs.commonCornerRadiusValue
        
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 4
        teamLogoImageView.layer.cornerRadius = 35
    }
    
    func configure(data: Team) {
        teamNameLabel.textColor = UIColor(hexString: data.brandColor)
        teamLogoImageView.downloaded(url: data.logoImage)
        teamNameLabel.text = data.fullName
        wonValueLabel.text = "\(data.won)"
        drawValueLabel.text = "\(data.draw)"
        lossLabel.text = "\(data.loss)"
    }
}
