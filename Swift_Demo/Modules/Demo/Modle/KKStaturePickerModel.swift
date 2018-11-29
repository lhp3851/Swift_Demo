//
//  KKStaturePickerModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKStaturePickerModel: KKPickerModel {

    override var unit: String?{
        get{
            return "cm"
        }
        set{}
    }
    
    
    var localDatas:[String]  {
        get{
            var number = [String]()
            number.append("")
            for item in stride(from: 120, to: 250, by: 1) {
                number.append(String(format: "%i", item))
            }
            number.append("")
            return number
        }
        set{}
    }
    
    override var title: String? {
        get {
            return "cm"
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
            return SelectorType.stature
        }
        set {}
    }
    
    
    override func setPickerView() -> (KKPickerSubView) {
        return KKStaturePickerView()
    }
}
