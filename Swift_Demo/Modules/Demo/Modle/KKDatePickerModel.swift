//
//  KKDatePickerModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKDatePickerModel: KKPickerModel {
    
    var components:DateComponents {
        let calendar = Calendar.init(identifier: .gregorian)
        let components = calendar.dateComponents([.year,.month,.day], from: currentDate)
        return components
    }
    
    var currentDate:Date {
        return Date()
    }
    
    var year:Int {
        return components.year ?? 2018
    }
    
    var month:Int {
        return components.month ?? 11
    }
    
    var monthes:[String] = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    
    var day:Int {
        return components.day ?? 01
    }
    
    var localDatas:[[String]]  {
        get{
            var datas = [[String]]()
            var years:[String] = [String]()
            years.append("")
            for item in stride(from: 1950, to: year, by: 1) {
                years.append(String(format: "%i", item))
            }
            years.append("")
            datas.append(years)
            datas.append(monthes)
            return datas
        }
        set{}
    }
    
    override var title: String? {
        get {
            return "日期"
        }
        set {}
    }
    
    override var datas: Any?  {
        get {
            return localDatas
        }
        set{
            localDatas = newValue as! [[String]]
        }
    }
    
    override var type: SelectorType? {
        get {
            return SelectorType.date
        }
        set {}
    }
    
    
    override func setPickerView() -> (KKPickerSubView) {
        return KKDatePickerView.init(frame: CGRect.zero)
    }
}
