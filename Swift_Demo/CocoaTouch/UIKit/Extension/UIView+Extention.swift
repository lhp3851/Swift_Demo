//
//  UIView+Extention.swift
//  ZhaoCaiMao_Swift
//
//  Created by mac on 2017/9/13.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit

extension UIView{
    //圆角
    func corner(radii: CGFloat) {
        if radii > 0 {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = radii
        }
    }

}
