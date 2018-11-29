//
//  Const.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/11.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit


/// 项目配置等常量
let kWINDOW_WIDTH  = (min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
let kWINDOW_HEIGHT = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))

let kMARGIN_HORIZONE : CGFloat = 16.0  //统一水平边距
let kNAVIGATION_BAR_HEIGHT : CGFloat = 44.0
let kSTATU_BAR_HEIGHT  : CGFloat     = 20.0
let kTAB_BAR_HEIGHT : CGFloat        = 49.0
let kNAVIGATION_STATU_BAR_HEIGHT = kNAVIGATION_BAR_HEIGHT + kSTATU_BAR_HEIGHT
let kSUB_VC_BOUNDS   =  kFIT_INSTANCE.fitFrame(frame: CGRect.init(x: 0, y: 0, width: 275.0, height: 250.0))

/// 字符串常量:三方资源key等
let kSERVICE_PHONE = "18588255659" //客服电话
let kAPP_VERSION   = "kAPP_VERSION"// APP 版本号
let kBAI_DU_MAP_KEY = "g0GMA2RuGOlSZhwPlO29Up1GDTjSZTZ3"//百度地图key

///系统
let kSYSTEM_VERSION = UIDevice().systemVersion

//字体大小
let kFONT_11 =  UIFont.systemFont(ofSize: 11)
let kFONT_12 =  UIFont.systemFont(ofSize: 12)
let kFONT_13 =  UIFont.systemFont(ofSize: 13)
let kFONT_14 =  UIFont.systemFont(ofSize: 14)
let kFONT_15 =  UIFont.systemFont(ofSize: 15)
let kFONT_16 =  UIFont.systemFont(ofSize: 16)
let kFONT_18 =  UIFont.systemFont(ofSize: 18)
let kFONT_20 =  UIFont.systemFont(ofSize: 20)
let kFONT_24 =  UIFont.systemFont(ofSize: 24)
let kFONT_30 =  UIFont.systemFont(ofSize: 30)
let kFONT_36 =  UIFont.systemFont(ofSize: 36)
let kFONT_40 =  UIFont.systemFont(ofSize: 40)


/// 适配对象
let  kFIT_INSTANCE = FitTool.shareInstance
func kIMAGE_WITH(name:String) -> (UIImage) {
    let image = FilesManagerTool.imageWithNames(imageName: name)
    return image
}

func kIMAGE_WITH(name:String,needOften:Bool) -> (UIImage) {
    let image = FilesManagerTool.imageWithNames(imageName: name,needOffen:needOften)
    return image
}


//颜色
let kCOLOR_NAVIGATION = kRGBColorFromHex(rgbValue: 0xf9671e)    //主色/navigation渐变/按钮 normal

let kCOLOR_SUBSIDIARY = kRGBColorFromHex(rgbValue:0xffa600)     //辅助色/点缀/部分模块底色

let kCOLOR_BUTTON_NORMOL = kRGBColorFromHex(rgbValue:0xf9671e)  //默认button 普通色

let kCOLOR_BUTTON_HEIGHT = kRGBColorFromHex(rgbValue:0xe95e19)  //默认button 高亮色

let kCOLOR_ANNOTATION = kRGBColorFromHex(rgbValue: 0xc8c8c8)    //特定button高亮字体色 注释颜色

let kCOLOR_TEXT_FIRST = kRGBColorFromHex(rgbValue:0x333333)     //一级文字/突出文字

let kCOLOR_TEXT_SECOND   = kRGBColorFromHex(rgbValue:0x666666)  //二级文字/正文文字

let kCOLOR_TEXT_THIRDLY  = kRGBColorFromHex(rgbValue:0xaaaaaa)  //三级颜色/辅助文字

let kCOLOR_TEXT_FOURTHLY = kRGBColorFromHex(rgbValue:0xcccccc)  //四级颜色/辅助注释

let kCOLOR_NOTTOUCH   = kRGBColorFromHex(rgbValue:0xe6e6e6)     //不可点击状态/线/文字注释

let kCOLOR_WHITE      = kRGBColorFromHex(rgbValue:0xffffff)     //部分背景/字体泛白/icon泛白

let kCOLOR_BACKGROUND = kRGBColorFromHex(rgbValue:0xf9f5f4)     //统一背景色

let kCOLOR_SAFELY     = kRGBColorFromHex(rgbValue:0x13ca17)     //安全/降序

let kCOLOR_LINK       = kRGBColorFromHex(rgbValue:0x3679f5)     //一般链接文字

let kCOLOR_WARNING    = kRGBColorFromHex(rgbValue:0xff3a39)     //警告色/警示文字/提示背景

let kCOLOR_STATUS_CLICK  = kRGBColorFromHex(rgbValue:0xfafafa)  //条栏点击态

let kCOLOR_TABBAR_GRAY   = kRGBColorFromHex(rgbValue:0xbfbfbf)  //TABBAR 默认状态颜色

let kCOLOR_WALLET_LITTLE = kRGBColorFromHex(rgbValue:0xfba78b)  //钱包余额小字

let kCOLOR_TRANSLUCENT =  kRGBColorFromHex(rgbValue:0x000000,alpha:0.6)//半透明色

let kCOLOR_CLEAR = kRGBColorFromHex(rgbValue:0xfffff0,alpha:0.0)       //透明色

let kCOLOR_SEARCH_BAR  = kRGBColorFromHex(rgbValue:0xf0f0f0)     //条栏点击态

let kCOLOR_BACKGROUND_COLOR  = kRGBColorFromHex(rgbValue:0xeaecee)     //tableview 背景色

let KCOLOR_TINT_COLOR = kRGBColorFromHex(rgbValue:0x6595F4)         //tintcolor

let KCOLOR_SEPERATE_LINE = kRGBColorFromHex(rgbValue:0xedeff0) 

func kRGBColorFromHex(rgbValue: Int) -> (UIColor) {
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                   alpha: 1.0)
}

func kRGBColorFromHex(rgbValue: Int,alpha:CGFloat) -> (UIColor) {
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                   alpha: alpha)
}



