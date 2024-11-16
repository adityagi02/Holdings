//
//  Holdings.swift
//  UpstoxHolding
//
//  Created by Aditya Tyagi on 17/11/24.
//

import Foundation

// MARK: - Holdings
struct Holdings {
    var userHoldings: [UserHolding]
    var totalCurrentValue: Double {
        userHoldings.map { $0.currentValue }.reduce(0, +)
    }
    var totalInvestment: Double {
        userHoldings.map { $0.investmentValue }.reduce(0, +)
    }
    var totalPNL: Double {
        totalCurrentValue - totalInvestment
    }
    var totalTodaysPNL: Double {
        userHoldings.map { $0.todayPNL }.reduce(0, +)
    }
    var totalPercentage: Double {
        ((totalCurrentValue - totalInvestment)/totalInvestment)*100
    }
}

// MARK: - UserHolding
struct UserHolding {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double

    var currentValue: Double {
        ltp * Double(quantity)
    }
    var investmentValue: Double {
        avgPrice * Double(quantity)
    }
    var pnl: Double {
        currentValue - investmentValue
    }
    var todayPNL: Double {
        (close - ltp) * Double(quantity)
    }
}

