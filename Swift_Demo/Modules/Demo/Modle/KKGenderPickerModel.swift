//
//  KKGenderPickerModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKGenderPickerModel: KKPickerModel {
    var localDatas = ["","男","女","其他",""]
    
    override var title: String? {
        get {
            return "教育程度"
        }
        set {}
    }
    
    override var datas: Any?  {
        get {
            return localDatas
        }
        set{
            localDatas = newValue as! [String]
        }
    }
    
    override var type: SelectorType? {
        get {
            return SelectorType.gender
        }
        set {}
    }
    
    
    override func setPickerView() -> (KKPickerSubView) {
        return KKGenderPickerView()
    }
}