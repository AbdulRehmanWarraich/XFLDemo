//
//  TeamPlayerNameCell.swift
//  XFLDemo
//
//  Created by AbdulRehman on 010/03/2021.
//

import UIKit

class TeamPlayerNameCell: UITableViewCell {

    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var aTeamNameLabel: UILabel!
    @IBOutlet weak var bTeamNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure(aTeamPlayerName: String?, bTeamPlayerName: String?, hideSeparator: Bool = false) {
        aTeamNameLabel.text = aTeamPlayerName
        bTeamNameLabel.text = bTeamPlayerName
        separatorView.isHidden = hideSeparator
    }
}
