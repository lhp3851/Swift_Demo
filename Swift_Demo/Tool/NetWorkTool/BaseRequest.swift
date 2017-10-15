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

    func isReachabile() -> Bool {
        return  (Reachability()?.connection != .none)
    }
    
}
