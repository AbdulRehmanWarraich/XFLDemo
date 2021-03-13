//
//  FixturesViewModelTests.swift
//  XFLDemoTests
//
//  Created by AbdulRehman on 13/03/2021.
//

import XCTest
@testable import XFLDemo

class FixturesViewModelTests: XCTestCase {
    var returnExpectation : XCTestExpectation?
    var errorResponse: Error?
    
    func testValidateScheduledMatchesSuccess() {
        
        let viewModel: FixturesViewModel = FixturesViewModel()
        
        returnExpectation = self.expectation(description: "Fixtures test")
        
        viewModel.delegate = self
        viewModel.bootstrap()
        
        waitForExpectations(timeout: AppConfigs.requestTimeOut)
        XCTAssertNotNil(viewModel.dataSource)
        XCTAssertGreaterThanOrEqual(viewModel.dataSource.count, 0)
    }
}

extension FixturesViewModelTests: FixturesViewModelDelegate {

    func willLoadData() {
    }
    
    func didLoadData() {
    }
    
    func presentMatchDetails() {
        returnExpectation?.fulfill()
    }
}

