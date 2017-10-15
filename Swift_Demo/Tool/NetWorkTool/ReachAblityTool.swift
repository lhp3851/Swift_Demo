//
//  ReachAblityTool.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/13.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit
import Alamofire

class ReachAblityTool: NSObject {

    typealias NetWorkStatus = NetworkReachabilityManager.NetworkReachabilityStatus
    
    typealias NetWorkType = NetworkReachabilityManager.ConnectionType
    
    typealias Listener = (NetWorkStatus) -> Void
    
    static let `default` = ReachAblityTool()
    private override init() {
        
    }
    
    /// 网络状态
    var netWorkStatus : NetWorkStatus? {
        
        return NetworkReachabilityManager()?.networkReachabilityStatus
        
    }
    
    /// 网络类型
    var netWorkType : NetWorkType?  {
        
        if (NetworkReachabilityManager()?.isReachableOnWWAN)! {
            return NetWorkType.wwan
        }
        else{
            return NetWorkType.ethernetOrWiFi
        }
    
    }
    
    
    /// 网络是否可达
    var isReachable : Bool {
        
        return (NetworkReachabilityManager()?.isReachable)!
        
    }
    
    open var listener: Listener?

    
}
