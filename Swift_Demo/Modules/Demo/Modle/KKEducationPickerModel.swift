//
//  KKEducationSelectorModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKEducationPickerModel: KKPickerModel {
    var defaultDatas = ["","博士或以上","研究生","本科","大专","高中","初中或以下","其他",""]
    
    override var title: String? {
        get {
            return "教育程度"
        }
        set {}
    }
    
    override var datas: [Any]?  {
        get {
            return defaultDatas
        }
        set{
            defaultDatas = newValue as! [String]
        }
    }
    
    override var type: SelectorType? {
        get {
            return SelectorType.education
        }
        set {}
    }
    
    
    override func setPickerView() -> (KKPickerSubView) {
        return KKEducationPickerView()
    }
}
