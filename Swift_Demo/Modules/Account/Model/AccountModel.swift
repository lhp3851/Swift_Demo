//
//  AccountModel.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/27.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit
import SQLite3

class AccountModel: NSObject {
    
    static let shareInstance = AccountModel()
    private override init() {}
    
    var account : String?
    var password : String?
    var session : String?
    
    
}
