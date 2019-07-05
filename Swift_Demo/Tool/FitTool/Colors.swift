//
//  Colors.swift
//  Swift_Demo
//
//  Created by sumian on 2019/7/5.
//  Copyright © 2019 Jerry. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func hex(_ rgbValue: Int,alpha:CGFloat = 1.0) -> (UIColor) {
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                       alpha: alpha)
    }
    
}

extension UIColor {
    
    static let kNAVIGATION    = UIColor.hex(0xf9671e)         //主色/navigation渐变/按钮 normal
    
    static let kSUBSIDIARY    = UIColor.hex(0xffa600)           //辅助色/点缀/部分模块底色
    
    static let kBUTTON_NORMOL = UIColor.hex(0xf9671e)           //默认button 普通色
    
    static let kBUTTON_HEIGHT = UIColor.hex(0xe95e19)           //默认button 高亮色
    
    static let kANNOTATION    = UIColor.hex( 0xc8c8c8)          //特定button高亮字体色 注释颜色
    
    static let kTEXT_FIRST    = UIColor.hex(0x333333)           //一级文字/突出文字
    
    static let kTEXT_SECOND   = UIColor.hex(0x666666)           //二级文字/正文文字
    
    static let kTEXT_THIRDLY  = UIColor.hex(0xaaaaaa)           //三级颜色/辅助文字
    
    static let kTEXT_FOURTHLY = UIColor.hex(0xcccccc)           //四级颜色/辅助注释
    
    static let kNOTTOUCH   = UIColor.hex(0xe6e6e6)              //不可点击状态/线/文字注释
    
    static let kWHITE      = UIColor.hex(0xffffff)              //部分背景/字体泛白/icon泛白
    
    static let kBACKGROUND = UIColor.hex(0xf9f5f4)              //统一背景色
    
    static let kSAFELY     = UIColor.hex(0x13ca17)              //安全/降序
    
    static let kLINK       = UIColor.hex(0x3679f5)              //一般链接文字
    
    static let kWARNING    = UIColor.hex(0xff3a39)              //警告色/警示文字/提示背景
    
    static let kSTATUS_CLICK  = UIColor.hex(0xfafafa)           //条栏点击态
    
    static let kTABBAR_GRAY   = UIColor.hex(0xbfbfbf)           //TABBAR 默认状态颜色
    
    static let kWALLET_LITTLE = UIColor.hex(0xfba78b)           //钱包余额小字
    
    static let kTRANSLUCENT =  UIColor.hex(0x000000,alpha:0.6)  //半透明色
    
    static let kCLEAR = UIColor.hex(0xfffff0,alpha:0.0)         //透明色
    
    static let kSEARCH_BAR  = UIColor.hex(0xf0f0f0)             //条栏点击态
    
    static let kBACKGROUND_COLOR  = UIColor.hex(0xeaecee)       //tableview 背景色
    
    static let kTINT_COLOR = UIColor.hex(0x6595F4)              //tintcolor
    
    static let kSEPERATE_LINE = UIColor.hex(0xedeff0)
    
}
