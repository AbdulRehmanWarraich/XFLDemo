//
//  HomeViewModelTest.swift
//  XFLDemoTests
//
//  Created by AbdulRehman on 13/03/2021.
//

import XCTest
@testable import XFLDemo

class HomeViewModelTest: XCTestCase {
    var returnExpectation : XCTestExpectation?
    var errorResponse: Error?
    
    func testValidateUserLogInSuccess() {
        
        let viewModel: HomeViewModel = HomeViewModel()
        errorResponse = nil
        returnExpectation = self.expectation(description: "Home test")
        
        viewModel.delegate = self
        viewModel.bootstrap()
        viewModel.signOut()
        
        waitForExpectations(timeout: AppConfigs.requestTimeOut)
        XCTAssertNil(errorResponse)
    }
}

extension HomeViewModelTest: HomeViewModelDelegate {
    
    func willLoadData() {
    }
    
    func didLoadData() {
    }
    
    func loggedOutSuccessfully() {
        returnExpectation?.fulfill()
    }
    
    func failedToLogOut(_ error: Error) {
        errorResponse = error
        returnExpectation?.fulfill()
    }
}
