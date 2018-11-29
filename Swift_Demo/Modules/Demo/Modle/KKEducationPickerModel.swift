//
//  KKEducationSelectorModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKEducationPickerModel: KKPickerModel {
    var localDatas = ["高中","大学","研究生","博士"]
    
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
            return SelectorType.education
        }
        set {}
    }
    
    
    override func setPickerView() -> (KKPickerSubView) {
        return KKEducationPickerView()
    }
}
