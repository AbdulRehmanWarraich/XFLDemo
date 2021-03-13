//
//  MatchViewModelTest.swift
//  XFLDemoTests
//
//  Created by AbdulRehman on 13/03/2021.
//

import XCTest
import ObjectMapper
@testable import XFLDemo

class MatchViewModelTest: XCTestCase {
    var returnExpectation : XCTestExpectation?
    var errorResponse: Error?
    
    func testValidateUserLogInSuccess() {
        
        guard let matchObject: Match = Mapper<Match>().map(JSONString: "{\"bTeamKey\":\"-LtLHtwL5bH90bZNccrW\",\"bTeam\":{\"id\":\"xfl_4\",\"fullName\":\"Python Assassins\",\"won\":3,\"logoImage\":\"https:\\/\\/firebasestorage.googleapis.com\\/v0\\/b\\/testproject-d09b9.appspot.com\\/o\\/TeamLogos%2FPA.jpeg?alt=media&token=cc8ee5cf-3b3e-44e6-b896-a0f360e24622\",\"players\":[{\"name\":\"PA 1\"},{\"name\":\"PA 2\"},{\"name\":\"PA 3\"},{\"name\":\"PA 4\"},{\"name\":\"PA 5\"},{\"name\":\"PA 6\"}],\"brandColor\":\"7a00d4\",\"name\":\"PA\",\"loss\":7,\"draw\":1},\"datestamp\":\"2021-03-13T02:02:00+0500\",\"aTeamKey\":\"-LtLHtwEx39cStIhv7gT\",\"aTeam\":{\"fullName\":\"Bug Busters\",\"brandColor\":\"#f77400\",\"name\":\"BB\",\"id\":\"xfl_1\",\"draw\":1,\"won\":2,\"logoImage\":\"https:\\/\\/firebasestorage.googleapis.com\\/v0\\/b\\/testproject-d09b9.appspot.com\\/o\\/TeamLogos%2FBB.jpeg?alt=media&token=c0a46740-81c4-45b0-81aa-eb6b20ed00e6\",\"loss\":0,\"players\":[{\"name\":\"BB 1\"},{\"name\":\"BB 2\"},{\"name\":\"BB 3\"},{\"name\":\"BB4\"},{\"name\":\"BB 5\"},{\"name\":\"BB 6\"}]}}")
        else {
            XCTFail("Failed to parse json")
            return
        }
        
        XCTAssertNotNil(matchObject)
        
        let viewModel :MatchViewModel = MatchViewModel(matchObject)
        viewModel.matchDetail?.aTeam?.key = matchObject.aTeamKey
        viewModel.matchDetail?.bTeam?.key = matchObject.bTeamKey
        XCTAssertNotNil(viewModel)
        
        errorResponse = nil
        returnExpectation = self.expectation(description: "Login test")
        
        viewModel.delegate = self
        viewModel.bootstrap()
        viewModel.storeMatchResult(aTeamGoal: 1, bTeamGoal: 3)
        
        waitForExpectations(timeout: AppConfigs.requestTimeOut)
        XCTAssertNil(errorResponse)
        
    }
}

extension MatchViewModelTest: MatchViewModelDelegate {
    
    func willLoadData() {
    }
    
    func didLoadData() {
    }
    func matchResultSavedSuccessfully(_ successMessage: String) {
        returnExpectation?.fulfill()
    }
    
    func failedToSaveMatchResult(_ error: Error) {
        errorResponse = error
        returnExpectation?.fulfill()
    }
}

