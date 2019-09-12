//
//  RyScreen.swift
//  SleepDoctor
//
//  Created by sumian on 2019/6/19.
//  Copyright © 2019 sumian. All rights reserved.
//

import UIKit

extension UIScreen {
    static let width  = (min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
    static let height = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height))
    
    static let vMargin:CGFloat = 15.0
    static let hMargin:CGFloat = 15.0
    
    static let maxContentWidth:CGFloat = UIScreen.width - UIScreen.hMargin * 2
    static let maxContentHeight:CGFloat = UIScreen.width - UIScreen.vMargin * 2
    
    static var baseSize: CGSize = CGSize(width: 375, height: 667)
    static var plusSize: CGSize = CGSize(width: 414, height: 736)
    
    var subWindow:CGRect {
        return CGRect.init(x: 0, y: 0, width: 275.0, height: 250.0).fit
    }
    
    var retina: CGFloat {
        return UIScreen.main.scale
    }
    
    var ppi: CGFloat  {
        if retina == 3,UIScreen.height > UIScreen.plusSize.height {
            return 458
        } else if retina == 3 {
            return 401
        } else {
            return 326
        }
    }
    
    var inch: CGFloat {
        let bounds = UIScreen.main.nativeBounds
        let  temp : CGFloat  = sqrt(pow(bounds.size.width, 2) + pow(bounds.size.height, 2)) / self.ppi
        return temp
    }
    
}

class RyiPhoneScreen: NSObject {
    
    static let minWidth:CGFloat = 320.0
    
    static let maxWidth:CGFloat = 414.0
    
    static let minHeight:CGFloat = 568.0
    
    static let maxHeight:CGFloat = 896.0
    
    static let minFontScale:CGFloat = 1.0
    
    static let maxFontScale:CGFloat = 3.0
    
}


class RyiPadScreen: NSObject {
    
    static let minWidth:CGFloat = 768.0
    
    static let maxWidth:CGFloat = 1024.0
    
    static let minHeight:CGFloat = 1024.0
    
    static let maxHeight:CGFloat = 1336.0
    
    static let minFontScale:CGFloat = 1.0
    
    static let maxFontScale:CGFloat = 2.0
    
}

class RyScreen: NSObject {
    
    static var minWidth:CGFloat {
        if UIDevice.iPhone() {
            return RyiPhoneScreen.minWidth
        } else {
            return RyiPadScreen.minWidth
        }
    }
    
    static var maxWidth:CGFloat {
        if UIDevice.iPhone() {
            return RyiPhoneScreen.maxWidth
        } else {
            return RyiPadScreen.maxWidth
        }
    }
    
    static var minHeight:CGFloat {
        if UIDevice.iPhone() {
            return RyiPhoneScreen.minHeight
        } else {
            return RyiPadScreen.minHeight
        }
    }
    
    static var maxHeight:CGFloat {
        if UIDevice.iPhone() {
            return RyiPhoneScreen.maxHeight
        } else {
            return RyiPadScreen.maxHeight
        }
    }
    
    static var minFontScale:CGFloat {
        if UIDevice.iPhone() {
            return RyiPhoneScreen.minFontScale
        } else {
            return RyiPadScreen.minFontScale
        }
    }
    
    static var maxFontScale:CGFloat {
        if UIDevice.iPhone() {
            return RyiPhoneScreen.maxFontScale
        } else {
            return RyiPadScreen.maxFontScale
        }
    }
    
}
