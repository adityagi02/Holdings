//
//  BottomViewState.swift
//  UpstoxHolding
//
//  Created by Aditya Tyagi on 17/11/24.
//

import Foundation

enum BottomViewState {
    case collapsed, expanded
    
    mutating func toggle() {
        self = self == .collapsed ? .expanded : .collapsed
    }
    var viewHeight: CGFloat {
        switch self {
        case .collapsed:
            return 40
        case .expanded:
            return 150
        }
    }
    
    var imageName: String {
        switch self {
        case .collapsed:
            return "chevron.up"
        case .expanded:
            return "chevron.down"
        }
    }
}
