//
//  KKSelectorModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

enum SelectorType : String{
    case education
    case address
    case date
    case time
    case dateAndTime
    case weight
    case stature
    case skt
}

class KKSelectorModel: KKBaseModel {
    
    var type: SelectorType!
    
    var selectorDatas:Any!
    
    static let groupDatas : [String:[String]] = {
        let datas = ["Selector":["education","address","date","time","dateAndTime","weight","stature","skt"]]
        return datas
    }()
    
    init(type:SelectorType,datas:Any) {
        self.type = type
        self.selectorDatas = datas
    }
}
