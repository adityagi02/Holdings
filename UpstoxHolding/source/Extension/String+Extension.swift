//
//  String+Extension.swift
//  UpstoxHolding
//
//  Created by Aditya Tyagi on 16/11/24.
//

import Foundation
import UIKit

extension String {
    func appendAsterisk() -> String {
        return self + "*"
    }
    
    func insideCase() -> String {
        return "(\(self))"
    }
}

extension NSMutableAttributedString {
    func appendIcon(_ iconName: String) {
        let textAttachment = NSTextAttachment()
        textAttachment.image = UIImage(systemName: iconName)
        textAttachment.bounds = CGRect(x: 0, y: 0, width: 12, height: 8)
        append(.init(string: " "))
        append(.init(attachment: textAttachment))
    }
}

extension UIStackView {
    func setup(_ axis: NSLayoutConstraint.Axis = .vertical,
               _ spacing: CGFloat = 18) {
        translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        alignment = .fill
    }

    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Double {
    var rupeesValue: String {
        var format = "₹%.2f"
        if isNegative {
            format = "-₹%.2f"
        }
        return String(format: format, abs(self))
    }

    var isNegative: Bool {
        self < 0
    }
    
    var getPercentage: String {
        let percentage = String(format: "%.2f", abs(self))
        return "\(percentage)%"
    }
}
