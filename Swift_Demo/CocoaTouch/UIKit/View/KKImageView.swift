//
//  KKImageView.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/11/12.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class KKImageView: UIImageView,UIGestureRecognizerDelegate {

    typealias ClickAction = (UIImageView) -> ()
    
    private(set) var action : ClickAction?
    
    init(frame: CGRect,action:@escaping ClickAction) {
        super.init(frame: frame)
        self.action = action
        let tapGuesture = UITapGestureRecognizer.init(target: self, action: #selector(action(object:)))
        tapGuesture.delegate = self
        self.addGestureRecognizer(tapGuesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error ~")
    }

    //点击事件
    @objc func action(object:UIImageView) -> Void {
        guard let actionLocal = self.action else { return }
        actionLocal(object)
    }
 
    
    
}
