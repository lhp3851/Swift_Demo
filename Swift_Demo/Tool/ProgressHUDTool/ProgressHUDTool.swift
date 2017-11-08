//
//  ProgressHUDTool.swift
//  Swift_Demo
//
//  Created by 刘合鹏 on 2017/10/17.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MBProgressHUD

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
    
    
    class func showHUD(toView:UIView) -> Void {
        let hud = MBProgressHUD.showAdded(to: toView, animated: true)
        hud.mode = .indeterminate
        hud.animationType = .zoom
        hud.margin = kMARGIN_HORIZONE
        hud.offset = CGPoint.init(x: 0, y: 0)
        hud.isSquare = false
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            hud.hide(animated: true)
        }
    }
    
    class func showAutomaticHUD(toView:UIView) -> Void {
        self.showHUD(toView: toView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.hieHUD(view: toView)
        }
    }
    
    class func hieHUD(view:UIView) -> Void {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
}
