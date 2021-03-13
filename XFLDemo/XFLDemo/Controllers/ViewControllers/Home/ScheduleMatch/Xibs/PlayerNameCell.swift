//
//  PlayerNameCell.swift
//  XFLDemo
//
//  Created by AbdulRehman on 10/03/2021.
//

import UIKit

class PlayerNameCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure(data: Player?, showSeparator: Bool) {
        playerNameLabel.text = data?.name
        separatorView.isHidden = showSeparator
    }
    
}
