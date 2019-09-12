//
//  KKWeightPickerModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKWeightPickerModel: KKPickerModel {
    
    static let share = KKWeightPickerModel()
    
    var intPart:[String] {
        get {
            var temp = [String]()
            temp.append("")
            for item in stride(from: 25, to: 200, by: 1) {
                temp.append(String(format: "%d", item))
            }
            temp.append("")
            return temp
        }
        set {}
    }
    
    var fractionalPart:[String] = ["","0","1","2","3","4","5","6","7","8","9","",]
    
    var defaultDatas:[[String]] {
        get {
            var temp = [[String]]()
            temp.append(intPart)
            temp.append(fractionalPart)
            return temp
        }
        set {}
    }
    
    
    override var datas: [Any]?{
        get {
            return defaultDatas
        }
        set {
            defaultDatas = [newValue as! [String]]
        }
    }
    
    override var title: String?{
        get {
            return "体重"
        }
        set {}
    }
    
    override var type: SelectorType?{
        get {
            return SelectorType.weight
        }
        set {}
    }
    
    override var defaultIndex: [Int] {
        get {
            return [0,0,0]
        }
        set {}
    }
}
