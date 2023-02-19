//
//  DeauthTests.swift
//  GBShopTests
//
//  Created by Константин on 15.02.2023.
//

import XCTest
@testable import GBShop

final class DeauthTests: XCTestCase {
    
    var requestFactory: RequestFactory!

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
    }

    override func tearDownWithError() throws {
        requestFactory = nil
    }
    
    func testLogoutWithValidValues() {
        let userId = 123
        let expectation = XCTestExpectation(description: #function)
        let deauth = requestFactory.makeDeauthRequestFactory()
        
        deauth.logout(userId: userId) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(1, result.result)
                XCTAssertNil(result.errorMessage)
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLogoutWithInvalidValues() {
        let userId = 0
        let expectation = XCTestExpectation(description: #function)
        let deauth = requestFactory.makeDeauthRequestFactory()
        
        deauth.logout(userId: userId) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(0, result.result)
                XCTAssertNotNil(result.errorMessage)
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
