//
//  HoldingsViewModel.swift
//  UpstoxHolding
//
//  Created by Aditya Tyagi on 17/11/24.
//

import Foundation
import UIKit

protocol HoldingsViewModelProtocol {
    init(getHoldingsUseCase: GetHoldingUseCase)
    var updateUI: (() -> Void)? { get set }
    var holdings: Holdings { get }
    var userHoldings: [UserHolding] { get }
    func fetchHoldings()
}

final class HoldingsViewModel: HoldingsViewModelProtocol {
    // MARK: Public Parameters
    var updateUI: (() -> Void)?
    var userHoldings: [UserHolding] {
        holdings.userHoldings
    }
    
    // MARK: Private Parameters
    private let getHoldingsUseCase: GetHoldingUseCase
    private(set) var holdings: Holdings = .init(userHoldings: []) {
        didSet {
            updateUI?()
        }
    }
    private var task: Task<Void, Never>?
    // MARK: Intializers
    required init(getHoldingsUseCase: GetHoldingUseCase) {
        self.getHoldingsUseCase = getHoldingsUseCase
    }

    // MARK: Public Methods
    func fetchHoldings() {
        cancelTask()
        task = Task { [weak self] in
            guard let self else { return }
            do {
                self.holdings = try await self.getHoldingsUseCase.execute()
            } catch {
                // Handle error more gracefully, e.g., show an error message to the user.
                self.updateUI?()
                print(error)
            }
        }
    }

    private func cancelTask() {
        task?.cancel()
    }

    deinit {
        cancelTask()
        print("deinit called for :\(String(describing: self))")
    }
}

enum Colors {
    
    static var profitGreen: UIColor? {
        return UIColor(hex: "#2eba87")
    }
    
    static var lossRed: UIColor? {
        return UIColor(hex: "#f25059")
    }
    
    static var backgroundBlue: UIColor? {
        return UIColor(hex: "#013264")
    }
    
    static var bottomSheetBackground: UIColor? {
        return UIColor(hex: "#f4f5f5")
    }
}




