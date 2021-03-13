//
//  NSError+Extension.swift
//  XFLDemo
//
//  Created by AbdulRehman on 10/03/2021.
//

import Foundation

extension NSError {
    class func create(code: Int = 0, reason: String, description: String) -> NSError {
        return NSError(domain: AppConfigs.appDomain, code: code, userInfo: [NSLocalizedDescriptionKey : description, "Error_reason": reason])
    }
}
