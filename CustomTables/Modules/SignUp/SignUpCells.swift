//
//  SignUpCells.swift
//  CustomTables
//
//  Created by Arturo Ventura on 11/10/22.
//

import UIKit
import FacilCustomApp
import AVFoundation

protocol CustomTablesCell: UITableViewCell {
    static var reusableName: String {get}
    static func registerToTable(table: UITableView)
}

extension CustomTablesCell {
    static func registerToTable(table: UITableView) {
        table.register(Self.self, forCellReuseIdentifier: Self.reusableName)
    }
}

class SignUpNameCell: UITableViewCell, CustomTablesCell {
    
    static let reusableName: String = "SignUpNameCell"
    
    let TitleColor = UIColor.Medium_Purple
    
    weak var nameTextField: DecoredTextField?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        let nameLabel = UILabel.CustomInstance(font: .Medium, size: .Big, color: TitleColor, text: "Name:")
        let nameTextField = DecoredTextField(listener: nil, filter: nil, text: nil)
        let stackView = UIStackView.CustomInstance(axis: .vertical, spacing: 8.0, arrangedSubviews: [nameLabel, nameTextField])
        contentView.addSubviewFill(stackView, padding: .allSame(8))
        self.nameTextField = nameTextField
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func fillData(listener: CustomTextFieldListener?, filter: CustomTextFieldFilter?, currentText: String?) {
        nameTextField?.listener = listener
        nameTextField?.filter = filter
        nameTextField?.text = currentText
    }
    
    
}

protocol SignUpPhotoCellListener: NSObject {
    func tapTakePhoto()
}

class SignUpPhotoCell: UITableViewCell, CustomTablesCell {
    
    static var reusableName: String = "SignUpPhotoCell"
    
    let ButtonColor = UIColor.Medium_Purple
    let ButtonTitleTakePhoto = "Take Photo"
    let ButtonTitleRetakePhoto = "Retake"
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    weak var previewView: UIView?
    weak var imageViewCaptured: UIImageView?
    weak var button: UIButton?
    weak var listener: SignUpPhotoCellListener?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        let previewView = UIView()
        previewView.clipsToBounds = true
        previewView.layer.cornerRadius = 8
        previewView.anchor(size: CGSize(width: 250, height: 250))
        self.previewView = previewView
        
        let imageViewCaptured = UIImageView()
        imageViewCaptured.anchor(size: CGSize(width: 250, height: 250))
        imageViewCaptured.contentMode = .scaleAspectFill
        imageViewCaptured.clipsToBounds = true
        imageViewCaptured.layer.cornerRadius = 8
        self.imageViewCaptured = imageViewCaptured
        
        let button = UIButton(type: .system)
        button.tintColor = ButtonColor
        button.addTarget(self, action: #selector(handleTakePhoto), for: .touchUpInside)
        self.button = button
        
        let mainStack = UIStackView.CustomInstance(axis: .vertical,  alignment: .center, spacing: 8, arrangedSubviews: [previewView, imageViewCaptured, button])
        contentView.addSubviewFill(mainStack, padding: .allSame(8))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func fillData(listener: SignUpPhotoCellListener, image: UIImage?) {
        self.listener = listener
        self.imageViewCaptured?.image = image
        previewView?.isHidden = image != nil
        self.imageViewCaptured?.isHidden = image == nil
        self.button?.setTitle(image == nil ? ButtonTitleTakePhoto : ButtonTitleRetakePhoto, for: .normal)
    }
    
    func prepareAppear() -> AVCapturePhotoOutput? {
        guard !(captureSession?.isRunning ?? false) else {
            return stillImageOutput
        }
        let captureSession = AVCaptureSession()
        self.captureSession = captureSession
        captureSession.sessionPreset = .medium
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("Front camera not available")
            return nil
        }
        do {
            let input = try AVCaptureDeviceInput(device: frontCamera)
            let stillImageOutput = AVCapturePhotoOutput()
            self.stillImageOutput = stillImageOutput
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview(captureSession: captureSession)
                return stillImageOutput
            }
                
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func setupLivePreview(captureSession: AVCaptureSession) {
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.videoPreviewLayer = videoPreviewLayer
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView?.layer.addSublayer(videoPreviewLayer)
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession?.startRunning()
            DispatchQueue.main.async { [weak self] in
                self?.videoPreviewLayer?.frame = self?.previewView?.bounds ?? CGRect.zero
            }
        }
    }
    
    func prepareDisappear() {
        captureSession?.stopRunning()
    }
    
    @objc func handleTakePhoto() {
        listener?.tapTakePhoto()
    }
}

class SignUpDescriptionCell: UITableViewCell, CustomTablesCell {
    
    static let reusableName: String = "SignUpDescriptionCell"
    
    let DescriptionColor = UIColor.Medium_Purple
    
    weak var descriptionLabel: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let descriptionLabel = UILabel.CustomInstance(font: .Regular, size: .Regular, color: DescriptionColor)
        descriptionLabel.numberOfLines = 0
        self.descriptionLabel = descriptionLabel
        contentView.addSubviewFill(descriptionLabel, padding: .allSame(8))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func fillData(descriptionText: String?) {
        descriptionLabel?.text = descriptionText
    }
}
