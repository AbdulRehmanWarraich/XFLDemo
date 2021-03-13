//
//  ScheduleMatchViewModelTests.swift
//  XFLDemoTests
//
//  Created by AbdulRehman on 13/03/2021.
//

import XCTest
@testable import XFLDemo

class ScheduleMatchViewModelTests: XCTestCase {
    var returnExpectation : XCTestExpectation?
    var errorResponse: Error?
    
    func testTeamListSuccess() {
        
        let viewModel: ScheduleMatchViewModel = ScheduleMatchViewModel()
        
        returnExpectation = self.expectation(description: "Teams list")
        
        viewModel.delegate = self
        viewModel.bootstrap()
        
        waitForExpectations(timeout: AppConfigs.requestTimeOut)
        XCTAssertNotNil(viewModel.dataSource)
        XCTAssertGreaterThanOrEqual(viewModel.dataSource.count, 0)
    }
    
    func testScheduleMatchSuccess() {
        
        let viewModel: ScheduleMatchViewModel = ScheduleMatchViewModel()
        
        returnExpectation = self.expectation(description: "Teams list")
        viewModel.selectedDate = Date()
        viewModel.selectedATeam = Team(JSONString: "{\"name\":\"BB\",\"loss\":2,\"players\":[{\"name\":\"BB 1\"},{\"name\":\"BB 2\"},{\"name\":\"BB 3\"},{\"name\":\"BB4\"},{\"name\":\"BB 5\"},{\"name\":\"BB 6\"}],\"draw\":2,\"fullName\":\"Bug Busters\",\"logoImage\":\"https:\\/\\/firebasestorage.googleapis.com\\/v0\\/b\\/testproject-d09b9.appspot.com\\/o\\/TeamLogos%2FBB.jpeg?alt=media&token=c0a46740-81c4-45b0-81aa-eb6b20ed00e6\",\"brandColor\":\"#f77400\",\"id\":\"xfl_1\",\"won\":3}")
        viewModel.selectedBTeam = Team(JSONString: "{\"players\":[{\"name\":\"PA 1\"},{\"name\":\"PA 2\"},{\"name\":\"PA 3\"},{\"name\":\"PA 4\"},{\"name\":\"PA 5\"},{\"name\":\"PA 6\"}],\"name\":\"PA\",\"loss\":8,\"draw\":2,\"logoImage\":\"https:\\/\\/firebasestorage.googleapis.com\\/v0\\/b\\/testproject-d09b9.appspot.com\\/o\\/TeamLogos%2FPA.jpeg?alt=media&token=cc8ee5cf-3b3e-44e6-b896-a0f360e24622\",\"brandColor\":\"7a00d4\",\"id\":\"xfl_4\",\"fullName\":\"Python Assassins\",\"won\":5}")
        viewModel.delegate = self
        viewModel.scheduleMatch()
        
        waitForExpectations(timeout: AppConfigs.requestTimeOut)
        XCTAssertNil(errorResponse)
        XCTAssertEqual(viewModel.selectedATeam?.id, "xfl_1")
    }
    
    func testScheduleMatchFailure() {
        
        let viewModel: ScheduleMatchViewModel = ScheduleMatchViewModel()
        
        returnExpectation = self.expectation(description: "Teams list")
        viewModel.selectedDate = Date()
        viewModel.selectedATeam = Team(JSONString: "")
        viewModel.selectedBTeam = Team(JSONString: "")
        viewModel.delegate = self
        viewModel.scheduleMatch()
        
        waitForExpectations(timeout: AppConfigs.requestTimeOut)
        XCTAssertNotNil(errorResponse)
        XCTAssertNotEqual(viewModel.selectedATeam?.id, "xfl_1")
    }
}

extension ScheduleMatchViewModelTests: ScheduleMatchViewModelDelegate {
   
    func willLoadData() {
    }
    
    func didLoadData() {
        returnExpectation?.fulfill()
    }
    
    func matchScheduleSuccessfully() {
        returnExpectation?.fulfill()
    }
    
    func failedToScheduleMatch(_ error: Error) {
        errorResponse = error
        returnExpectation?.fulfill()
    }
}
