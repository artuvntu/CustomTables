//
//  SignUpViewController.swift
//  CustomTables
//
//  Created by Arturo Ventura on 11/10/22.
//

import UIKit
import AVFoundation
import FacilCustomApp

class SignUpViewController: CustomViewController {
    
    weak var table: UITableView?
    weak var stillImageOutput: AVCapturePhotoOutput?
    override func hasTextField() -> Bool {
        true
    }
    let cellsClass: [CustomTablesCell.Type] = [SignUpNameCell.self, SignUpPhotoCell.self, SignUpDescriptionCell.self]
    var nameText: String = ""
    var imageCaptured: UIImage?
    var viewModel = SignUpViewModel()
    let alphabeticFilter = AlphabeticFilter()
    
    override func loadView() {
        super.loadView()
        title = "Sign Up"
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.delaysContentTouches = false
        table.separatorStyle = .none
        SignUpNameCell.registerToTable(table: table)
        SignUpPhotoCell.registerToTable(table: table)
        SignUpDescriptionCell.registerToTable(table: table)
        view.addSubviewAnchor(table, top: view.safeTopAnchor, leading: view.safeLeadingAnchor, bottom: view.safeBottomAnchor, trailing: view.safeTrailingAnchor, padding: .axisSame(vertical: 16, horizontal: 8))
        self.table = table
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Medium_Purple]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .Medium_Purple
    }
    
    func reloadSignUpPhotoCell() {
        let indexpaths = cellsClass.enumerated().filter({($0).element is SignUpPhotoCell.Type}).map({IndexPath(row: ($0).offset, section: 0)})
        table?.beginUpdates()
        table?.reloadRows(at: indexpaths, with: .fade)
        table?.endUpdates()
    }
}

extension SignUpViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellsClass.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CellClass = cellsClass[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellClass.reusableName)
        switch CellClass {
        case is SignUpNameCell.Type:
            let signUpCell = cell as? SignUpNameCell
            signUpCell?.fillData(listener: self, filter: alphabeticFilter, currentText: nameText)
        case is SignUpPhotoCell.Type:
            let signUpPhotoCell = cell as? SignUpPhotoCell
            signUpPhotoCell?.fillData(listener: self, image: imageCaptured)
        case is SignUpDescriptionCell.Type:
            let signUpDescriptionCell = cell as? SignUpDescriptionCell
            signUpDescriptionCell?.fillData(descriptionText: viewModel.getDescription())
        default:
            break
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let CellClass = cellsClass[indexPath.row]
        if CellClass is SignUpPhotoCell.Type {
            let signUpCell = cell as? SignUpPhotoCell
            stillImageOutput = signUpCell?.prepareAppear()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let CellClass = cellsClass[indexPath.row]
        if CellClass is SignUpPhotoCell.Type {
            let signUpCell = cell as? SignUpPhotoCell
            signUpCell?.prepareDisappear()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        let CellClass = cellsClass[indexPath.row]
        if CellClass is SignUpDescriptionCell.Type {
            show(ChartsViewController(), sender: nil)
        }
    }
}

extension SignUpViewController: CustomTextFieldListener {
    func onKeyPress(view: CustomTextField, text: String) {
        self.nameText = text
    }
}

extension SignUpViewController: SignUpPhotoCellListener {
    func tapTakePhoto() {
        if imageCaptured == nil {
            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            stillImageOutput?.capturePhoto(with: settings, delegate: self)
        } else {
            let alert = UIAlertController(title: "Retake photo?", message: "you will retake photo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] _ in
                self?.imageCaptured = nil
                self?.reloadSignUpPhotoCell()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel))
            self.present(alert, animated: true)
        }
        
    }
}

extension SignUpViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }
        if let image = UIImage(data: imageData) {
            self.imageCaptured = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .leftMirrored)
        }

        reloadSignUpPhotoCell()
    }
}
