//
//  String+Extension.swift
//  XFLDemo
//
//  Created by AbdulRehman on 06/03/2021.
//

import Foundation

extension Optional where Wrapped == String {
    func isValidEmail() -> Bool {
        if let text = self{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: text)
        }
        return false
    }
    
    func isValidPassword() -> Bool {
        if let text = self,
           text.count >= AppConfigs.passwordLegnth {
            return true
        }
        return false
    }
}
