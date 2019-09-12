//
//  QRCodeVeiwControllerViewController.swift
//  Swift_Demo
//
//  Created by Jerry on 2017/10/27.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    lazy var device :AVCaptureDevice = {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        
        return device!
    }()
    
    lazy var input : AVCaptureDeviceInput = {
        let input = try!  AVCaptureDeviceInput.init(device: self.device)

        return input
    }()
    
    lazy var output : AVCaptureMetadataOutput = {
        let out = AVCaptureMetadataOutput.init()
        out.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        return out
    }()
    
    lazy var session : AVCaptureSession = {
        let session = AVCaptureSession.init()
        session.sessionPreset = AVCaptureSession.Preset.high
        return session
    }()
    
    lazy var connection : AVCaptureConnection = {
        let conn = self.output.connection(with: AVMediaType.video)
        return conn!
    }()
    
    lazy var preview : AVCaptureVideoPreviewLayer = {
        let preview = AVCaptureVideoPreviewLayer.init(session: self.session)
        preview.frame = UIScreen.main.bounds
        return preview
    }()
    
    
    lazy var rightItem:UIBarButtonItem = {
        let item = UIBarButtonItem.init(image: UIImage.named("sweep_icon"),
                                        style: .done,
                                        target: self,
                                        action: #selector(getImage(sender:)))
        return item
    }()
    
    lazy var pickerVC:UIImagePickerController = {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.delegate = self
        vc.sourceType = .photoLibrary
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initPannel() {
        super.initPannel()
        navigationItem.rightBarButtonItem = rightItem
    }
    
    override func initData() {
        super.initData()
        self.navigationItem.title = "二维码扫描"
        
        if self.session.canAddInput(self.input) {
            self.session.addInput(self.input)
        }
        
        if self.session.canAddOutput(self.output) {
            self.session.addOutput(self.output)
        }
        
        self.output.metadataObjectTypes = [AVMetadataObject.ObjectType.dataMatrix]
        self.view.layer.insertSublayer(self.preview, at: 0)
        self.session.startRunning()
        
    }
    
    @objc func getImage(sender:UIBarButtonItem){
        present(pickerVC, animated: true) {
            
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        
        if metadataObjects.count > 0 {
            self.session.stopRunning()
            for metadataObject in metadataObjects {
                let object : AVMetadataMachineReadableCodeObject = metadataObject as! AVMetadataMachineReadableCodeObject
                print(object.stringValue!)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

       
        let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)]
        fetchImageInfo(image: image as! UIImage) { (reslut) in
            print("reslut:",reslut ?? "thereis no intresting datas")
            self.pickerVC.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerVC.dismiss(animated: true, completion: nil)
    }
    
    func fetchImageInfo(image:UIImage,complemention:@escaping (String?) -> Void) {
        let detector = CIDetector.init(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        guard let data = image.pngData() else {return}
        guard let ciImage = CIImage.init(data: data) else {return}
        let features = detector?.features(in: ciImage)
        if let result:CIQRCodeFeature = features?.first as? CIQRCodeFeature {
            let vc =  UIAlertController.init(title: "二维码内容" , message: result.messageString ?? "", preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .default) { (action) in
                complemention(result.messageString)
            }
            vc.addAction(action)
           pickerVC.present(vc, animated: true, completion: nil)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
