//
//  ExtensionUILabel.swift
//  CustomTables
//
//  Created by Arturo Ventura on 11/10/22.
//

import UIKit

extension UILabel {
    
    static func CustomInstance(font: UIFont, color: UIColor = .black, text: String? = nil, textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.text = text
        label.textAlignment = textAlignment
        return label
    }
    
    static func CustomInstance(font: FontDefault, size: CGFloat, color: UIColor = .black, text: String? = nil, textAlignment: NSTextAlignment = .left) -> UILabel {
        CustomInstance(font: font.of(size: size), color: color, text: text, textAlignment: textAlignment)
    }
    
    static func CustomInstance(font: FontDefault, size: FontSizes, color: UIColor = .black, text: String? = nil, textAlignment: NSTextAlignment = .left) -> UILabel {
        CustomInstance(font: font, size: size.rawValue, color: color, text: text, textAlignment: textAlignment)
    }
}
