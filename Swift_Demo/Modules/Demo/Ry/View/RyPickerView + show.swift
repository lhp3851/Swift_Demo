//
//  RyPickerView + show.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/25.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView: UIGestureRecognizerDelegate{
    func show(){
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        setupBgView()
        bgView.frame = keyWindow.bounds
        bgView.alpha = 0.5
        bgView.addSubview(self)
        frame = CGRect(x: 0, y: keyWindow.bounds.height,
                       width: keyWindow.bounds.size.width,
                       height: preferredHeight)
        let h = preferredHeight
        keyWindow.addSubview(bgView)
        UIView.animate(withDuration: 0.3) {
            self.bgView.alpha = 1
            self.frame = CGRect(x: 0, y: keyWindow.bounds.height-h,
                                width: keyWindow.bounds.size.width,
                                height: h)
        }
    }
    
    func hide(){
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = self.frame.offsetBy(dx: 0, dy: self.preferredHeight)
            self.bgView.alpha = 0
        }) { (_) in
            self.bgView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    @objc func onBgViewTap(sender: UITapGestureRecognizer){
        hide()
    }
    
    static let bgView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return temp
    }()

    fileprivate static var isTapSet: Bool = false
    
    fileprivate func setupBgView(){
        if RyPickerView.isTapSet{
            return
        }
        RyPickerView.isTapSet = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(onBgViewTap(sender:)))
        tap.delegate = self
        bgView.addGestureRecognizer(tap)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let location = touch.location(in: bgView)
        if frame.contains(location){
            return false
        }
        return true
    }
    
    fileprivate var bgView: UIView{
        return RyPickerView.bgView
    }
}

