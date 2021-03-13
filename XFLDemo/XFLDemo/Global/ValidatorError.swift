//
//  ValidatorError.swift
//  XFLDemo
//
//  Created by AbdulRehman on 11/03/2021.
//

class ValidatorError<T>{
    var type: T
    var errorMessage: String

    init(_ type: T, message: String? = "") {
        self.type = type
        errorMessage = (((message ?? "").isEmpty == false) ? (message ?? "") : Constants.generalError)
    }
}
