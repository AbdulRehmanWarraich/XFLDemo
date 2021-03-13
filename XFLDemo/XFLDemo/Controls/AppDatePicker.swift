//
//  AppDatePicker.swift
//  XFLDemo
//
//  Created by AbdulRehman on 08/03/2021.
//

import UIKit

class AppDatePicker: UIViewController {
    
    //MARK: - Properties
    typealias XFLDatePickerCompletionHandler = (_ selectedDate:Date) -> ()
    var doneCompletionBlock: XFLDatePickerCompletionHandler?
    
    var currentDate: Date = Date()
    var pickerMode: UIDatePicker.Mode = .date
    
    //MARK: - IBOutlet
    @IBOutlet var myContentView: UIView!
    @IBOutlet var buttonContentView: UIView!
    
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    //MARK: - View Controllers Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.appShadowBlack.withAlphaComponent(0.5)
        
        myContentView.layer.cornerRadius = AppConfigs.commonCornerRadiusValue
        
        doneButton.setTitle("Done", for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        
        datePicker.setDate(currentDate, animated: true)
        datePicker.datePickerMode = pickerMode
         
    }
    
    deinit {
        print("\(String(describing: self)) deinit called")
    }
    
    //MARK: - Functions
    func setDatePicker(currentDate : Date, mode: UIDatePicker.Mode = .dateAndTime, didSelectDateBlock : @escaping XFLDatePickerCompletionHandler) {
        self.currentDate = currentDate
        self.pickerMode = mode
        doneCompletionBlock = didSelectDateBlock
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == self.view {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - IBAction
    @IBAction func donePressed(_ sender: UIButton) {
        doneCompletionBlock?(datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
