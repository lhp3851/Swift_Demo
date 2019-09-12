//
//  KKDatePickerModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKDatePickerModel: KKPickerModel {
    
    static let share = KKDatePickerModel()
    
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
    
    var monthes:[String] = ["","01","02","03","04","05","06",
                            "07","08","09","10","11","12",""]
    
    var day:Int {
        return components.day ?? 01
    }
    
    var days:[String] = ["","01","02","03","04","05",
                         "06","07","08","09","10","11",
                         "12","13","14","15","16","17",
                         "18","19","20","21","22","23",
                         "24","25","26","27","28","29",
                         "30",""]
    
    var defaultDatas:[[String]]  {
        get{
            var datas = [[String]]()
            var years:[String] = [String]()
            years.append("")
            for item in stride(from: 1930, to: year, by: 1) {
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
    
    override var datas: [Any]?  {
        get {
            return defaultDatas
        }
        set{
            defaultDatas = newValue as! [[String]]
        }
    }
    
    override var type: SelectorType? {
        get {
            return SelectorType.date
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
        return KKDatePickerView.init(frame: CGRect.zero, model: model)
    }
}
