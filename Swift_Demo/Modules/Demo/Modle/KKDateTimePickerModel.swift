//
//  KKDateTimePickerModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKDateTimePickerModel: KKPickerModel {
    
    static let share = KKDateTimePickerModel()
    
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
    
    var day:Int {
        return components.day ?? 01
    }
    
    var monthes:[String] = ["","01","02","03","04","05","06",
                            "07","08","09","10","11","12",""]
    
    
    var days:[String] = ["","01","02","03","04","05",
                         "06","07","08","09","10","11",
                         "12","13","14","15","16","17",
                         "18","19","20","21","22","23",
                         "24","25","26","27","28","29",
                         "30",""]
    
    var houres:[String] = ["","00","01","02","03","04",
                           "05","06","07","08","09","10",
                           "11","12","13","14","15","16",
                           "17","18","19","20","21","22",
                           "23","24",""]
    
    var minutes:[String] = ["","00","01","02","03","04",
                            "05","06","07","08","09","10",
                            "11","12","13","14","15","16",
                            "17","18","19","20","21","22",
                            "23","24","25","26","27","28",
                            "29","30","31","32","33","34",
                            "35","36","37","38","39","40",
                            "41","42","43","44","45","46",
                            "47","48","49","50","51","52",
                            "53","54","55","56","57","58",
                            "59",""]
    
    var defaultDatas:[[String]] {
        get {
            var temp = [[String]]()
            var month_day = [String]()
            month_day.append("")
            for monteItem in monthes {
                if !monteItem.isEmpty {
                    for dayItem in days {
                        if !dayItem.isEmpty {
                            month_day.append(monteItem + "-" + dayItem)
                        }
                    }
                }
            }
            month_day.append("")
            temp.append(month_day)
            temp.append(houres)
            temp.append(minutes)
            return temp
        }
        set {
            
        }
    }
    
    override var title: String?{
        get {
            return "日期时间"
        }
        set {
            
        }
    }
    
    override var type: SelectorType?{
        get {
            return SelectorType.dateAndTime
        }
        set {}
    }
    
    override var datas: [Any]? {
        get {
            return defaultDatas
        }
        set {
            defaultDatas = [newValue as! [String]]
        }
    }
    
}
