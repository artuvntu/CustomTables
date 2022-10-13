//
//  SignUpViewModel.swift
//  CustomTables
//
//  Created by Arturo Ventura on 12/10/22.
//

import Foundation

class SignUpViewModel {
    
    func getDescription() -> String? {
        if let filepath = Bundle.main.path(forResource: "Description", ofType: "txt") {
            return try? String(contentsOfFile: filepath)
        } else {
            return nil
        }
    }
}
