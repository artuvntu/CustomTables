//
//  Fonts.swift
//  CustomTables
//
//  Created by Arturo Ventura on 11/10/22.
//

import UIKit

enum FontDefault: String {
    
    case Regular = "UIFont.Weight.regular"
    case Bold = "UIFont.Weight.bold"
    case Medium = "UIFont.Weight.medium"
    
    func of(size: CGFloat) -> UIFont {
        let weight: UIFont.Weight
        switch self {
        case .Regular:
            weight = .regular
        case .Bold:
            weight = .bold
        case .Medium:
            weight = .medium
        }
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    func of(size: FontSizes) -> UIFont {
        self.of(size: size.rawValue)
    }
}

enum FontSizes: CGFloat {
    case Regular = 16
    case Big = 24
    case ExtraBig = 50
}
