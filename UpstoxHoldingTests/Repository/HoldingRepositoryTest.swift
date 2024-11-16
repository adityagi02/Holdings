//
//  HoldingRepositoryTest.swift
//  UpstoxHoldingTests
//
//  Created by Aditya Tyagi on 17/11/24.
//

import XCTest
@testable import UpstoxHolding

final class HoldingRepositoryTest: XCTestCase {
    func test_GetHoldings_WithSuccessResponse() async {
        let networkManager = MockNetworkManager(fileName: "holdings_success_response")
        let repository = HoldingsRepositoryImpl(networkManager: networkManager)
        do {
            let response = try await repository.getHoldings()
            XCTAssertEqual(response.userHoldings.count, 5)
            XCTAssertEqual(response.totalTodaysPNL.rupeesValue, "-₹25131.15")
            XCTAssertEqual(response.totalCurrentValue.rupeesValue, "₹317307.00")
            XCTAssertEqual(response.totalInvestment.rupeesValue, "₹293629.45")
            XCTAssertEqual(response.totalPNL.rupeesValue, "₹23677.55")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_GetHoldings_WithEmptyResponse() async {
        let networkManager = MockNetworkManager(fileName: "holdings_empty_response")
        let repository = HoldingsRepositoryImpl(networkManager: networkManager)
        do {
            let response = try await repository.getHoldings()
            XCTAssertTrue(response.userHoldings.isEmpty)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_GetHoldings_WithFailureResponse() async {
        let networkManager = MockNetworkManager(fileName: "holdings_failure_response")
        let repository = HoldingsRepositoryImpl(networkManager: networkManager)
        do {
            _ = try await repository.getHoldings()
            XCTFail("Expecting faiilure here")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}


