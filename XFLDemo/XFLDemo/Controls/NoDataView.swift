//
//  NoDataView.swift
//  XFLDemo
//
//  Created by AbdulRehman on 08/03/2021.
//

import UIKit
class NoDataView: UIView {
    
    var imageView: UIImageView = UIImageView()
    var descriptionLabel: UILabel = UILabel()
    
    class var tagValue : Int {
        return 998877
    }
    // MARK: - Initialization
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setupViewLayout(_ imageName:String = "no_data", description: String?, descriptionColor :UIColor, descriptionFont :UIFont) {
        self.tag = NoDataView.tagValue
        self.backgroundColor = UIColor.clear
       
        
        imageView.backgroundColor = UIColor.clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 46).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 46).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        descriptionLabel.backgroundColor = UIColor.clear
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        
        setupViewLayoutValues(imageName, description: description, descriptionColor: descriptionColor, descriptionFont: descriptionFont)
    }
    
    func setupViewLayoutValues(_ imageName:String = "no_data", description: String?, descriptionColor :UIColor, descriptionFont :UIFont) {
        imageView.image = UIImage(named: imageName)
        descriptionLabel.textColor = descriptionColor
        descriptionLabel.font = descriptionFont
        descriptionLabel.text = description ?? ""
        descriptionLabel.textAlignment = .center
    }
}
