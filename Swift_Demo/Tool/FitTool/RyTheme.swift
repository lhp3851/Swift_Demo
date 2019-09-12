//
//  RyTheme.swift
//  SleepDoctor
//
//  Created by sumian on 2019/7/4.
//  Copyright © 2019 sumian. All rights reserved.
//

import UIKit

struct RyThemeSytle {
    enum Style:String {
        case `default`  = "white"
        case black      = "black"
        case system     = "system"
    }
    
    var style: String = Style.default.rawValue
}

struct RyTheme {
    
    let styleKeyPath:KeyPath<RyThemeSytle,String> = \RyThemeSytle.style
    
}
