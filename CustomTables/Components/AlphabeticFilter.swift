//
//  AlphabeticFilter.swift
//  CustomTables
//
//  Created by Arturo Ventura on 11/10/22.
//

import Foundation
import FacilCustomApp

class AlphabeticFilter: CustomTextFieldFilter {
    func filter(finalValue: String) -> Bool {
        finalValue.range(of: "[^a-zA-ZáéíóúÁÉÍÓÚñÑ ]", options: .regularExpression) == nil
    }
}
