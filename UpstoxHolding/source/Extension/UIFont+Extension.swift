//
//  UIFont+Extension.swift
//  UpstoxHolding
//
//  Created by Aditya Tyagi on 17/11/24.
//

import UIKit

enum Fonts {
    
    static var cellHeadingRegular: UIFont? {
        return UIFont.boldSystemFont(ofSize: 20)
    }
    
    static var cellHeadingMedium: UIFont? {
        return UIFont.systemFont(ofSize: 18)
    }
    
    static var cellSubHeadingRegular: UIFont? {
        return UIFont.preferredFont(forTextStyle: .caption2)
    }
    
    static var bottomHeadingRegular: UIFont? {
        return UIFont.systemFont(ofSize: 15, weight: .medium)
    }
}
