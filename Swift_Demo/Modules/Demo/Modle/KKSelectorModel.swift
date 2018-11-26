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

protocol KKSelectorModelProtocol {
    func setPickerView() -> (KKPickerSubView)
}

class KKSelectorModel: KKBaseModel,KKSelectorModelProtocol {
    
    var selectorDatas:Any!
    
    var type: SelectorType!
    
    static let groupDatas : [String:[String]] = {
        let datas = ["Selector":["education","address","date","time","dateAndTime","weight","stature","skt"]]
        return datas
    }()
    
    override init() {
        super.init()
    }
    
    init(type:SelectorType,datas:Any) {
        self.type = type
        self.selectorDatas = datas
    }
    
    func setPickerView() -> (KKPickerSubView) {
        return KKPickerSubView()
    }
}

