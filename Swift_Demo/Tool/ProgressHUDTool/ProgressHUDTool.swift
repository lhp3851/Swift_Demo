//
//  ProgressHUDTool.swift
//  Swift_Demo
//
//  Created by 刘合鹏 on 2017/10/17.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ProgressHUDTool: BaseView {

    static var activityView : NVActivityIndicatorView = {
        let frame = CGRect.init(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
        let view = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballClipRotate, color: kCOLOR_WHITE, padding: kMARGIN_HORIZONE)
        view.backgroundColor = kCOLOR_SAFELY
        return view
    }()

    
    func startAnimating() -> Void {
        ProgressHUDTool.activityView.startAnimating()
    }
    
    func stopAnimating() -> Void {
        ProgressHUDTool.activityView.stopAnimating()
    }
    
}
