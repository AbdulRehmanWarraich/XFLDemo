//
//  BaseViewModelDelegate.swift
//  XFLDemo
//
//  Created by AbdulRehman on 13/03/2021.
//

import Foundation

protocol BaseViewModelDelegate: class {
    func willLoadData()
    func didLoadData()
}

extension BaseViewModelDelegate {
    func didLoadData(){}
}
