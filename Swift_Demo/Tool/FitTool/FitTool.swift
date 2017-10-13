//
//  FitTool.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/20.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit

class FitTool: NSObject {

    static let shareInstance = FitTool()
    private override init() {
        
    }
    
    let kBASE_HEIGHT:CGFloat = 667.0
    let kBASE_WIDTH:CGFloat  = 375.0
    let kBASE_SCREEN_INCHE :CGFloat = 4.7
    
    let retina = UIDevice().retina

    
    func fitHeight(height:CGFloat) -> CGFloat {
        return height*kWINDOW_HEIGHT/kBASE_HEIGHT
    }
    
    func fitWidth(width:CGFloat) -> CGFloat {
        return width*kWINDOW_WIDTH/kBASE_WIDTH
    }
    
    func fitPoint(point : CGPoint) -> CGPoint {
        var kpoint :CGPoint = CGPoint()
        kpoint.x = point.x
        kpoint.y = point.y
        return kpoint
    }
    
    func fitSize(size:CGSize) -> CGSize {
        let width = self.fitWidth(width: size.width)
        let height = self.fitHeight(height: size.height)
        let size = CGSize.init(width: width, height: height)
        return size
    }

    func fitFrame(frame:CGRect) -> CGRect {
        let kpoint:CGPoint = frame.origin
        let width  = self.fitWidth(width: frame.size.width)
        let height = self.fitHeight(height: frame.size.height)
        let ksize  = CGSize.init(width: width, height: height)
        let kframe :CGRect = CGRect.init(origin: kpoint, size: ksize)
        return kframe
    }
    
    func fitFont(fontSize:CGFloat) -> UIFont {
        let inche  = UIDevice.current.inche
        return UIFont.systemFont(ofSize:inche*fontSize/kBASE_SCREEN_INCHE)
    }
    
    
}
