//
//  DecoredTextField.swift
//  CustomTables
//
//  Created by Arturo Ventura on 12/10/22.
//

import UIKit
import FacilCustomApp

class DecoredTextField: CustomTextField {
    
    let BorderColor = UIColor.Medium_Purple
    
    override func addTextField(textField: UITextField) {
        let square = UIView()
        square.layer.borderColor = BorderColor.cgColor
        square.layer.borderWidth = 2
        square.layer.cornerRadius = 8
        addSubviewFill(square, padding: .axisSame(vertical: 8, horizontal: 0))
        square.addSubviewFill(textField, padding: .allSame(8))
    }
}
