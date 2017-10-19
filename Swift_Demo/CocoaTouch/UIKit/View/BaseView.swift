//
//  BaseView.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/13.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class BaseView: UIView {

    func viewController()->BaseViewController?{
        var next:UIView? = self
        repeat{
            if let nextResponder = next?.next, nextResponder.isKind(of:BaseViewController.self){
                return (nextResponder as! BaseViewController)
            }
            next = next?.superview
        }while next != nil
        return nil
    }

}
