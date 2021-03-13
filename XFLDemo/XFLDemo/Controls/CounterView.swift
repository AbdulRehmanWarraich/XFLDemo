//
//  CounterView.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import UIKit

class CounterView: UIView {
    
    //MARK: - @IBOutlets
    var minusButton: UIButton!
    var counterValueLabel: UILabel!
    var plusButton: UIButton!
    
    //MARK: - Properties
    var countValue = 0 {
        didSet {
            if counterValueLabel != nil {
                counterValueLabel.text = "\(countValue)"
            }
        }
    }
    
    var isEnabled: Bool = true {
        didSet {
            minusButton.isEnabled = isEnabled
            plusButton.isEnabled = isEnabled
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViewLayout()
    }
    
    
    func setupViewLayout() {
        let buttonSize: CGFloat = 36
        self.backgroundColor = UIColor.viewControllerBackground
        
        counterValueLabel = UILabel()
        counterValueLabel.text = "\(countValue)"
        counterValueLabel.font = .regular(fontSize: 60)
        counterValueLabel.textColor = UIColor.black
        counterValueLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(counterValueLabel)
        counterValueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        counterValueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        minusButton = UIButton()
        minusButton.setImage(UIImage(named: "minus_icon"), for: .normal)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(minusButton)
        minusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        minusButton.trailingAnchor.constraint(equalTo: counterValueLabel.leadingAnchor, constant: -8).isActive = true
        minusButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        minusButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        minusButton.addTarget(self, action: #selector(minusButtonAction(_:)), for: .touchUpInside)
        
        plusButton = UIButton()
        plusButton.setImage(UIImage(named: "plus_icon"), for: .normal)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(plusButton)
        plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: counterValueLabel.trailingAnchor, constant: 8).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        plusButton.addTarget(self, action: #selector(plusButtonAction(_:)), for: .touchUpInside)
        
        self.layer.cornerRadius = AppConfigs.commonCornerRadiusValue
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.appRed.cgColor
        self.addShadow(color: UIColor.appShadowBlack)
        
    }
    
    //MARK: - IBAction
    @IBAction func minusButtonAction(_ sender: UIButton) {
        if countValue != 0 {
            countValue -= 1
        }
        counterValueLabel.text = "\(countValue)"
    }
    
    @IBAction func plusButtonAction(_ sender: UIButton) {
        countValue += 1
        counterValueLabel.text = "\(countValue)"
    }
}
