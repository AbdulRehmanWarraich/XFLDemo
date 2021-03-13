//
//  LoginViewModelTests.swift
//  XFLDemoTests
//
//  Created by AbdulRehman on 13/03/2021.
//

import XCTest
@testable import XFLDemo

class LoginViewModelTests: XCTestCase {
    var returnExpectation : XCTestExpectation?
    var errorResponse: Error?
    
    func testValidateUserLogInSuccess() {
        
        let viewModel :LoginViewModel = LoginViewModel()
        viewModel.userEmail = "admin@xgrid.com"
        viewModel.password = "test123"
        errorResponse = nil
        returnExpectation = self.expectation(description: "Login test")
        
        viewModel.delegate = self
        viewModel.bootstrap()
        viewModel.login()
        
        waitForExpectations(timeout: AppConfigs.requestTimeOut)
        XCTAssertNil(errorResponse)
        
    }
    
    func testValidateUserLogInFailure() {
        
        let viewModel :LoginViewModel = LoginViewModel()
        viewModel.userEmail = "test@test.com"
        viewModel.password = "test111"
        
        errorResponse = nil
        returnExpectation = self.expectation(description: "Login test")
        
        viewModel.delegate = self
        viewModel.bootstrap()
        viewModel.login()
        
        waitForExpectations(timeout: AppConfigs.requestTimeOut)
        XCTAssertNotNil(errorResponse)
    }
}

extension LoginViewModelTests: LoginViewModelDelegate {
    
    func willLoadData() {
    }
    
    func didLoadData() {
    }
    
    func loggedInSuccessfully() {
        returnExpectation?.fulfill()
    }
    
    func failedToLogIn(_ error: Error) {
        errorResponse = error
        returnExpectation?.fulfill()
    }
}
