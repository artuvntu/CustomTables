//
//  SplashViewController.swift
//  CustomTables
//
//  Created by Arturo Ventura on 11/10/22.
//

import UIKit
import FacilCustomApp

class SplashViewController: CustomViewController {
    fileprivate let TitleColor = UIColor.Tocao
    
    override func loadView() {
        super.loadView()
        let titleLabel = UILabel.CustomInstance(font: .Bold, size: .ExtraBig, color: TitleColor, text: "Custom Tables")
        view.addSubviewAnchor(titleLabel, centerX: view.centerXAnchor, centerY: view.centerYAnchor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: continueApp)
    }
    
    func continueApp() {
        show(SignUpViewController(), sender: nil)
    }
}
