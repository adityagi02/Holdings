//
//  InvestmentViewAttributes.swift
//  UpstoxHolding
//
//  Created by Aditya Tyagi on 17/11/24.
//

import Foundation
import UIKit

enum InvestmentViewAttributes {
    case pnl, todayPnl, totalInvestment, currentInvestment

    var attributedTitle: NSMutableAttributedString {
        var string = ""
        switch self {
        case .pnl:
            string = "Profit & Loss"
        case .todayPnl:
            string = "Today's Profit & Loss"
        case .totalInvestment:
            string = "Total Investment"
        case .currentInvestment:
            string = "Current value"
        }
        return NSMutableAttributedString(string: string.appendAsterisk(),
                                         attributes: [.font: Fonts.bottomHeadingRegular ?? .boldSystemFont(ofSize: 16),
                                                      .foregroundColor: UIColor.systemGray])
    }
    
    func secondLabelAttributeTitle(for holdings: Holdings?) -> NSAttributedString {
        guard let holdings else { return NSAttributedString() }
        var string = ""
        switch self {
        case .pnl:
            string = (holdings.totalPNL.rupeesValue + holdings.totalPercentage.getPercentage.insideCase())
        case .todayPnl:
            string = holdings.totalTodaysPNL.rupeesValue
        case .totalInvestment:
            string = holdings.totalInvestment.rupeesValue
        case .currentInvestment:
            string = holdings.totalCurrentValue.rupeesValue
        }
        return NSAttributedString(string: string,
                                  attributes: getSecondLabelTextAttributes(for: holdings))
    }
    
    private func getSecondLabelTextAttributes(for holdings: Holdings) -> [NSAttributedString.Key: Any]? {
        switch self {
        case .pnl:
            return [.foregroundColor: holdings.totalPNL.isNegative ? Colors.lossRed ?? .secondaryLabel : Colors.profitGreen ?? .secondaryLabel,
                    .font: Fonts.bottomHeadingRegular ?? .boldSystemFont(ofSize: 16)]
        case .todayPnl:
            return [.foregroundColor: holdings.totalTodaysPNL.isNegative ? Colors.lossRed ?? .secondaryLabel : Colors.profitGreen ?? .secondaryLabel,
                    .font: Fonts.bottomHeadingRegular ?? .boldSystemFont(ofSize: 16)]
        case .currentInvestment, .totalInvestment:
            return [.font: Fonts.bottomHeadingRegular ?? .boldSystemFont(ofSize: 16), .foregroundColor: UIColor.systemGray]
        }
    }
}

