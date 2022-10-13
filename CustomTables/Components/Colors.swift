//
//  Colors.swift
//  CustomTables
//
//  Created by Arturo Ventura on 11/10/22.
//

import UIKit
import FacilCustomApp

extension UIColor {
    static let Viking = UIColor(hexString: "56B6C4")
    static let Medium_Purple = UIColor(hexString: "9567E0")
    static let Tocao = UIColor(hexString: "6F3096")
    static let Vivid_Violet = UIColor(hexString: "06114F")
    static let Sapphire = UIColor(hexString: "F7A579")
    private static let ColorCycle = [UIColor.Viking, .Medium_Purple, .Tocao, .Vivid_Violet, .Sapphire]
    static func GetColorFor(_ number: Int) -> UIColor {
        let position = number % ColorCycle.count
        return ColorCycle[position]
    }
}
