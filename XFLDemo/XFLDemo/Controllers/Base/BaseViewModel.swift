//
//  BaseViewModel.swift
//  XFLDemo
//
//  Created by AbdulRehman on 07/03/2021.
//

import Foundation

protocol BaseViewModel {
    associatedtype T
    func bootstrap()
    var delegate: T? { get set }
}
