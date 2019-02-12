//
//  Torch.swift
//  BrowserFramework
//
//  Created by Jerry on 24/07/2018.
//  Copyright © 2018 bgwl. All rights reserved.
//

import UIKit
import AVFoundation

enum OperateTorchType {
    case On
    case Off
}

class Torch: NSObject {
    
    static let instance:Torch = Torch();
    private override init() {}
    func reset() ->Void{}

    let device = AVCaptureDevice.default(for: AVMediaType.video);
    
    /// 操作手电筒
    ///
    /// - Parameter type: on 表示要打开，off 表示要关闭
    func operateTorch(type:OperateTorchType) -> Void {
        assert(device != nil, "手电筒设备不可用")
        do{
           try device?.lockForConfiguration()
            if type==OperateTorchType.On {
                device?.torchMode = AVCaptureDevice.TorchMode.on
            }
            else {
                device?.torchMode = AVCaptureDevice.TorchMode.off
            }
            device?.unlockForConfiguration()
        }catch {
            print("手电筒不可用")
        }
    }
    
    
    /// 操作手电筒
    ///
    /// - Parameter type: on 表示要打开，off 表示要关闭
    func operateTorch() -> Void {
        assert(device != nil, "手电筒设备不可用")
        do{
            try device?.lockForConfiguration()
            if device?.torchMode == AVCaptureDevice.TorchMode.on {
                 device?.torchMode = AVCaptureDevice.TorchMode.off
            }
            else{
                 device?.torchMode = AVCaptureDevice.TorchMode.on
            }
            device?.unlockForConfiguration()
        }catch {
            print("手电筒不可用")
        }
    }
    
    
    /// 查询手电筒状态
    ///
    /// - Returns: 手电筒状态
    func getStatus() -> String {
        if device?.torchMode == AVCaptureDevice.TorchMode.on {
            return "ON"
        }
        else{
            return "OFF"
        }
    }
    
    
}
