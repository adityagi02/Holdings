//
//  HoldingsViewModelTest.swift
//  UpstoxHoldingTests
//
//  Created by Pritesh Singhvi on 13/11/24.
//

import XCTest
@testable import UpstoxHolding

final class HoldingsViewModelTest: XCTestCase {
    func test_fetchHoldings_WithSuccess() {
        let networkManager = MockNetworkManager(fileName: "holdings_success_response")
        let repository = HoldingsRepositoryImpl(networkManager: networkManager)
        let usecase = GetHoldingUseCaseImpl(repository: repository)
        let viewModel = HoldingsViewModel(getHoldingsUseCase: usecase)
        let expectation = XCTestExpectation(description: "success")
        viewModel.updateUI = {
            expectation.fulfill()
        }
        viewModel.fetchHoldings()
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.userHoldings.count, 5)
    }

    func test_fetchHoldings_WithEmpty() {
        let networkManager = MockNetworkManager(fileName: "holdings_empty_response")
        let repository = HoldingsRepositoryImpl(networkManager: networkManager)
        let usecase = GetHoldingUseCaseImpl(repository: repository)
        let viewModel = HoldingsViewModel(getHoldingsUseCase: usecase)
        let expectation = XCTestExpectation(description: "success")
        viewModel.updateUI = {
            expectation.fulfill()
        }
        viewModel.fetchHoldings()
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(viewModel.userHoldings.isEmpty)
    }
    
    func test_fetchHoldings_WithFailure() {
        let networkManager = MockNetworkManager(fileName: "holdings_failure_response")
        let repository = HoldingsRepositoryImpl(networkManager: networkManager)
        let usecase = GetHoldingUseCaseImpl(repository: repository)
        let viewModel = HoldingsViewModel(getHoldingsUseCase: usecase)
        let expectation = XCTestExpectation(description: "success")
        viewModel.updateUI = {
            expectation.fulfill()
        }
        viewModel.fetchHoldings()
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(viewModel.userHoldings.isEmpty)
    }
}
