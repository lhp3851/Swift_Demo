//
//  KKPasteBoardTool.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/8.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

protocol CopyItemProtocol {
    associatedtype Item
}

class KKPasteBoardTool: UIPasteboard {
    
    static let instance = UIPasteboard.general
    
    private override init() {
        
    }
    
    class func copy(contents:String)  {
        instance.string = contents
    }
    
    class func getContents() -> String {
        return instance.string ?? ""
    }
    
   
}
