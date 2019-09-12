//
//  FitTool.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/20.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit
import Foundation

enum RyFitToolStyle {
    case width
    case height
    case diagonal
}

extension CGPoint {
    var fit: CGPoint {
        return self
    }
}

extension Int {
    var cgFloat:CGFloat{
        return CGFloat(self)
    }
    
    var yfit:CGFloat {
        let sheight = self.cgFloat*UIScreen.height/RyFitTool.kBASE_HEIGHT
        if sheight.validate {
            return sheight
        } else if sheight > self.cgFloat.max {
            return self.cgFloat.max
        } else {
            return self.cgFloat.min
        }
    }
    
    var xfit:CGFloat {
        let swidth = self.cgFloat*UIScreen.width/RyFitTool.kBASE_WIDTH
        if swidth.validate {
            return swidth
        } else if swidth > self.cgFloat.max {
            return self.cgFloat.max
        } else {
            return self.cgFloat.min
        }
    }
}


extension Double {
    var cgFloat:CGFloat {
        return CGFloat(self)
    }
    
    var yfit:CGFloat {
        let sheight = self.cgFloat*UIScreen.height/RyFitTool.kBASE_HEIGHT
        if sheight.validate {
            return sheight
        } else if sheight > self.cgFloat.max {
            return self.cgFloat.max
        } else {
            return self.cgFloat.min
        }
    }
    
    var xfit:CGFloat {
        let swidth = self.cgFloat*UIScreen.width/RyFitTool.kBASE_WIDTH
        if swidth.validate {
            return swidth
        } else if swidth > self.cgFloat.max {
            return self.cgFloat.max
        } else {
            return self.cgFloat.min
        }
    }
}

extension CGFloat {
    
    var validate: Bool {
        if self <= self.max && self >= self.min {
            return true
        } else {
            return false
        }
    }
    
    static var minKey:String = "CGFloat.min"
    static var maxKey:String = "CGFloat.max"
    var min: CGFloat {
        set {
            objc_setAssociatedObject(self, &CGFloat.minKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let value = objc_getAssociatedObject(self, &CGFloat.minKey) as? CGFloat {
                return value
            }
            return self
        }
    }
    
    var max: CGFloat {
        set {
            objc_setAssociatedObject(self, &CGFloat.maxKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let value = objc_getAssociatedObject(self, &CGFloat.maxKey) as? CGFloat {
                return value
            }
            return self
        }
    }
    
    
    init(_ base:CGFloat,min:CGFloat,max:CGFloat) {
        self = base
        self.max = max
        self.min = min
    }
    
    var yfit:CGFloat {
        let sheight = self*UIScreen.height/RyFitTool.kBASE_HEIGHT
        if sheight.validate {
            return sheight
        } else if sheight > self.max {
            return self.max
        } else {
            return self.min
        }
    }
    
    var xfit:CGFloat {
        let swidth = self*UIScreen.width/RyFitTool.kBASE_WIDTH
        if swidth.validate {
            return swidth
        } else if swidth > self.max {
            return self.max
        } else {
            return self.min
        }
    }

    
    /// 宽度缩放，不会校验是否会超出屏幕，上面的方法会校验
    var x : CGFloat{
        let todo = self / RyFitTool.kBASE_WIDTH * UIScreen.main.bounds.width
        return todo
    }
    
    
    /// 高度缩放，不会校验是否会超出屏幕，上面的方法会校验
    var y : CGFloat{
        let todo = self / RyFitTool.kBASE_HEIGHT * UIScreen.main.bounds.height
        return todo
    }
    
}

extension CGSize {
    
    var ratio:CGFloat {
        return width / height
    }
    
    var validate: Bool {
        guard width <= 0 else {
            return false
        }
        guard height <= 0 else {
            return false
        }
        if width.validate  && height.validate {
            return true
        } else {
            return false
        }
    }
    
    var fit: CGSize {
        let width = self.width.xfit
        let height = self.height.yfit
        return CGSize(width: width, height: height)
    }
    
    func fit(with ratio:CGFloat) -> CGSize {
        let ssize = self.scale(with: ratio)
        if ssize.validate {
            return ssize
        }
        return self
    }
    
    func scale(with scale:CGFloat) -> CGSize {
        let sWidth = width * scale
        let sHeight = height * scale
        if sWidth.validate,sHeight.validate {
            return CGSize(width: sWidth, height: sHeight)
        } else if sWidth > width.max,sHeight > height.max {
            return CGSize(width: width.max, height: height.max)
        } else if sWidth > width.max {
            return CGSize(width: width.max, height: sHeight)
        } else if sHeight > height.max {
            return CGSize(width: sWidth, height: height.max)
        } else {
            return self
        }
    }
}

extension CGRect {
    var fit:CGRect {
        let kpoint:CGPoint = self.origin
        let ksize  = self.size.fit
        return CGRect(origin: kpoint, size: ksize)
    }
    
    func fit(with ratio:CGFloat) -> CGRect {
        let kpoint:CGPoint = self.origin
        let ksize  = self.size.fit(with: ratio)
        let kframe :CGRect = CGRect.init(origin: kpoint, size: ksize)
        return kframe
    }
}


class RyFitTool: NSObject {
    
    static let shared = RyFitTool()
    private override init() {}
    
    static let style:RyFitToolStyle = .width   //默认按照宽度优先的方式适配
    
    static let kBASE_HEIGHT:CGFloat = 667.0
    static let kBASE_WIDTH:CGFloat  = 375.0
    
    static let kBASE_SCREEN_INCHE :CGFloat = 4.7
        
}
