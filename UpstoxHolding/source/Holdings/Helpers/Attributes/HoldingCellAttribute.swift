//
//  HoldingCellAttribute.swift
//  UpstoxHolding
//
//  Created by Aditya Tyagi on 17/11/24.
//

import Foundation
import UIKit

enum HoldingCellAttribute {
    case name, ltp, netQty, pnl

    func attributedTitle(_ holding: UserHolding) -> NSMutableAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        func appendText(_ text: String, attributes: [NSAttributedString.Key: Any]) {
            mutableAttributedString.append(NSAttributedString(string: text, attributes: attributes))
        }
        switch self {
        case .name:
            appendText(holding.symbol, attributes: getValueAttributes(holding))
        case .ltp:
            appendText("LTP: ", attributes: titleAttributes)
            appendText(holding.ltp.rupeesValue, attributes: getValueAttributes(holding))
        case .netQty:
            appendText("NET QTY: ", attributes: titleAttributes)
            appendText("\(holding.quantity)", attributes: getValueAttributes(holding))
        case .pnl:
            appendText("P&L: ", attributes: titleAttributes)
            appendText(holding.pnl.rupeesValue, attributes: getValueAttributes(holding))
        }
        return mutableAttributedString
    }

    private var titleAttributes: [NSAttributedString.Key: Any] {
        [.foregroundColor: UIColor.gray,
         .font: Fonts.cellSubHeadingRegular ?? .boldSystemFont(ofSize: 16)]
    }

    private func getValueAttributes(_ holding: UserHolding) -> [NSAttributedString.Key: Any] {
        switch self {
        case .name:
            return [.font: Fonts.cellHeadingRegular ?? .boldSystemFont(ofSize: 16)]
        case .ltp, .netQty:
            return [.font: Fonts.cellHeadingMedium ?? .boldSystemFont(ofSize: 16)]
        case .pnl:
            return [.font: UIFont.systemFont(ofSize: 18),
                    .foregroundColor: holding.pnl.isNegative ? Colors.lossRed ?? .systemGray : Colors.profitGreen ?? .systemGray]
        }
    }
}
