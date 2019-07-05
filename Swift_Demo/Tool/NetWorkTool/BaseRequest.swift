//
//  BaseRequest.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/18.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Reachability

class BaseRequest: NSObject {

    private let reachability = try? Reachability()
    var isReachabile:Bool {
        get {
            if let  temp = reachability {
                return temp.connection != .unavailable
            } else {return false}
        }
        set {}
    }
    
}
