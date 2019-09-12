//
//  KKStaturePickerModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKStaturePickerModel: KKPickerModel {
    
    static let share = KKStaturePickerModel()

    override var unit: String?{
        get{
            return "　cm"
        }
        set{}
    }
    
    
    var defaultDatas:[[String]]  {
        get{
            var datas = [Any]()
            var number = [String]()
            number.append("")
            for item in stride(from: 120, to: 250, by: 1) {
                number.append(String(format: "%i", item))
            }
            number.append("")
            datas.append(number)
            return datas as! [[String]]
        }
        set{}
    }
    
    override var title: String? {
        get {
            return "身高"
        }
        set {}
    }
    
    override var datas: [Any]?  {
        get {
            return defaultDatas
        }
        set{
            defaultDatas = [newValue as! [String]]
        }
    }
    
    override var type: SelectorType? {
        get {
            return SelectorType.stature
        }
        set {}
    }
    
    override var defaultIndex: [Int] {
        get {
            return [0,0,0]
        }
        set {}
    }
    
    override func setPickerView(model: KKPickerModel) -> (KKPickerSubView) {
        
        return KKStaturePickerView.init(frame: CGRect.zero, model: model)
        
    }
}
