//
//  FixturesTableViewCell.swift
//  XFLDemo
//
//  Created by AbdulRehman on 010/03/2021.
//


import UIKit

class FixturesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var aTeamLogoImageView: UIImageView!
    @IBOutlet weak var aTeamNameLabel: UILabel!
    @IBOutlet weak var bTeamLogoImageView: UIImageView!
    @IBOutlet weak var bTeamNameLabel: UILabel!
    @IBOutlet weak var matchTimeLabel: UILabel!
    
    
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
        aTeamLogoImageView.layer.cornerRadius = 50
        bTeamLogoImageView.layer.cornerRadius = 50
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: Match, time: String?) {
        matchTimeLabel.text = time
        
        if let aTeamData = data.aTeam,
           let bTeamData = data.bTeam {
            aTeamNameLabel.text = aTeamData.name
            aTeamLogoImageView.downloaded(url: aTeamData.logoImage)
            bTeamNameLabel.text = bTeamData.name
            bTeamLogoImageView.downloaded(url: bTeamData.logoImage)
        } else {
            aTeamNameLabel.text = ""
            aTeamLogoImageView.downloaded(url: "")
            bTeamNameLabel.text = ""
            bTeamLogoImageView.downloaded(url: "")
        }
    }
}
