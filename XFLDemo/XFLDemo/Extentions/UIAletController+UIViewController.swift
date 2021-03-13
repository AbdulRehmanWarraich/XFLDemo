//
//  UIAletController+UIViewController.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import UIKit

public enum AlertType {
    case general
    case success
    case failure
}

//MARK:- Alerts
extension UIViewController {
    /**
     Show error popup with message.
     
     - parameter message: Message text that need to dispalyed.
     - parameter actionBlock: ok button action.
     
     - returns: void.
     */
    func showErrorAlertWith(message: String?, _ actionBlock : @escaping () -> () = {}) {
        var messageString :String = ""
        if let messageObject = message,
           messageObject.isEmpty == false {
            messageString = messageObject
        } else {
            messageString = Constants.generalError
        }
        self.showAlert(type: .failure, title: "Error", message: messageString, actionBlock)
    }
    
    /**
     Show success popup with message.
     
     - parameter message: Message text that need to dispalyed.
     - parameter actionBlock: ok button action.
     
     - returns: void.
     */
    func showSuccessAlertWith(message: String?, _ actionBlock : @escaping () -> () = {}) {
        
        self.showAlert(type: .success, title: "Successful",
                       message: (message?.isEmpty ?? true) ? Constants.generalError : message,
                       actionBlock)
    }
    
    /**
     Show popup with parameters.
     
     - parameter type: Type of Alert
     - parameter title: Popup titile.
     - parameter message: Message text that need to dispalyed.
     - parameter btnTitle: Ok button title. Bydefault its 'OK'.
     
     - returns: void.
     */
    func showAlert(type: AlertType = .general, title:String?, message : String?, btnTitle:String = "OK", _ actionBlock : @escaping () -> () = {}) {
        
        
        let alertViewController = self.createAlert(type: type, title: title, message: message, btnTitle: btnTitle, actionBlock)
        self.presentPOPUP(alertViewController, animated: true, modalTransitionStyle: UIModalTransitionStyle.crossDissolve, completion: nil)
    }
    
    func createAlert(type: AlertType = .general, title:String?, message : String?, btnTitle:String = "OK", _ actionBlock : @escaping () -> () = {}) -> UIViewController {
        
        let alertViewController = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: btnTitle, style: .default) { (action) in
            actionBlock()
        }
        
        alertViewController.addAction(okAction)
        return alertViewController
    }
    
    /**
     Show confirmation popup.
     */
    func showConfirmationAlert(title:String?,
                               message: String?,
                               okTitle:String = "OK",
                               cancelTitle:String = "CANCEL",
                               okActionBlock : @escaping () -> () = {},
                               cancelActionBlock : @escaping () -> () = {}) {
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { (action) in
            okActionBlock()
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
            cancelActionBlock()
        }
        
        alertViewController.addAction(okAction)
        alertViewController.addAction(cancelAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertViewController, animated: true, completion: nil)
        }
        
    }
}
