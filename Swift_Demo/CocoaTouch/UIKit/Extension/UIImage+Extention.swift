//
//  File.swift
//  ZhaoCaiMao_Swift
//
//  Created by mac on 2017/9/19.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit

extension UIImage {
    //颜色转化图片
    class func imageWithColor(color:UIColor) ->(UIImage){
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
