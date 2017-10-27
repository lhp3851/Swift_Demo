//
//  QRCodeVeiwControllerViewController.swift
//  Swift_Demo
//
//  Created by Jerry on 2017/10/27.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func initPannel() {
        super.initPannel()
        
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
    

   

}
