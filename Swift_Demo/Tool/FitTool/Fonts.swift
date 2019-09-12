//
//  Fonts.swift
//  Swift_Demo
//
//  Created by sumian on 2019/7/5.
//  Copyright © 2019 Jerry. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    // 字体适配器
    ///
    /// - Parameters:
    ///   - size: 设计的基准尺寸
    ///   - weight: 权重
    /// - Returns: 根据屏幕适配后的字体
    static func size(with size:CGFloat,weight: UIFont.Weight? = .regular) -> UIFont {
        let size = fitFont(size: size)
        if let weight = weight {
            return UIFont.systemFont(ofSize:size, weight: weight)
        } else {
            return UIFont.systemFont(ofSize:size)
        }
    }
    
    private static  func fitFont(size:CGFloat) -> CGFloat {
        let inch  = UIScreen.main.inch
        let ksize = inch*size/RyFitTool.kBASE_SCREEN_INCHE
        if ksize >= size.max {
            return size.max
        } else if ksize <= size.min {
            return size.min
        } else {
            return ksize
        }
    }
}


public extension UIFont {
    
    static let F10 = UIFont.size(with: 10)
    
    static let F11 = UIFont.size(with: 11)
    
    static let F12 = UIFont.size(with: 12)
    
    static let F13 = UIFont.size(with: 13)
    
    static let F14 = UIFont.size(with: 14)
    
    static let F15 = UIFont.size(with: 15)
    
    static let F16 = UIFont.size(with: 16)
    
    static let F18 = UIFont.size(with: 18)
    
    static let F20 = UIFont.size(with: 20)
    
    static let F21 = UIFont.size(with: 21)
    
    static let F22 = UIFont.size(with: 22)
    
    static let F24 = UIFont.size(with: 24)
    
    static let F26 = UIFont.size(with: 26)
    
    static let F30 = UIFont.size(with: 30)
    
    static let F36 = UIFont.size(with: 36)
    
    static let F40 = UIFont.size(with: 40)
    
    static let F44 = UIFont.size(with: 44)
    
    static let F64 = UIFont.size(with: 64)
    
    static let FM_11 = UIFont.size(with: 11, weight: .medium)
    
    static let FM_13 = UIFont.size(with: 13, weight: .medium)
    
    static let FM_14 = UIFont.size(with: 14, weight: .medium)
    
    static let FM_15 = UIFont.size(with: 15, weight: .medium)
    
    static let FM_16 = UIFont.size(with: 16, weight: .medium)
    
    static let FM_18 = UIFont.size(with: 18, weight: .medium)
    
    static let FM_21 = UIFont.size(with: 21, weight: .medium)
    
    static let FM_22 = UIFont.size(with: 22, weight: .medium)
    
    static let FM_30 = UIFont.size(with: 30, weight: .medium)
    
    static let FM_40 = UIFont.size(with: 140, weight: .medium)
    
}
