//
//  PointsViewModelTests.swift
//  XFLDemoTests
//
//  Created by AbdulRehman on 13/03/2021.
//

import XCTest
@testable import XFLDemo

class PointsViewModelTests: XCTestCase {
    var returnExpectation : XCTestExpectation?
    var errorResponse: Error?
    
    func testValidateTeamsListSuccess() {
        
        let viewModel: PointsViewModel = PointsViewModel()
        
        returnExpectation = self.expectation(description: "Teams matchs")
        
        viewModel.delegate = self
        viewModel.bootstrap()
        
        waitForExpectations(timeout: AppConfigs.requestTimeOut)
        XCTAssertNotNil(viewModel.dataSource)
        XCTAssertGreaterThanOrEqual(viewModel.dataSource.count, 0)
    }
}

extension PointsViewModelTests: PointsViewModelDelegate {
    func willLoadData() {
    }
    
    func didLoadData() {
    }
    
    func presentTeamsDetails() {
        returnExpectation?.fulfill()
    }
}
