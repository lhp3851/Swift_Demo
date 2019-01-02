//
//  RyPickerView + sd.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
//    static var heightPicker: RyPickerView{
//        let lHolder = RyPickerHolderData(width: .flexible)
//        let listItem = RyPickerListData(dataSource: RyIntData.itemsForHeight, width: .fixed(width:75), defaultIndex: 90)
//        let unitItem = RyPickerUnitData(width: .fixed(width:35), unit: "cm")
//        let rHolder = RyPickerHolderData(width: .flexible)
//        let cfg = RyPickerViewConfiguration(title: "身高",
//                                            items: [lHolder,listItem,unitItem,rHolder])
//        let temp = RyPickerView(dataSource: cfg)
//        let linkerHandler = RyLinkerScrollHandler(configuration: cfg, pickerView: temp)
//        cfg.linkerHandler = linkerHandler
//        return temp
//    }
//
//    static var educationPicker: RyPickerView{
//        let listItem = RyPickerListData(dataSource: RyIntData.itemsForEducation, width: .flexible, defaultIndex: 4)
//        let cfg = RyPickerViewConfiguration(title: "教育程度",items: [listItem])
//        let temp = RyPickerView(dataSource: cfg)
//        let linkerHandler = RyLinkerScrollHandler(configuration: cfg, pickerView: temp)
//        cfg.linkerHandler = linkerHandler
//        return temp
//    }
//
    static var genderPicker: RyPickerView{
        let container = RyListWidthContainer(.zero, .flexible, .zero)
        let listItem = RyPickerListData(dataSource: RyPikerRowData.itemsForGender, widthContainer: container)
        let cfg = RyPickerViewConfiguration(title: "性别",items: [listItem])
        let temp = RyPickerView(dataSource: cfg)
        return temp
    }
//
//    static var date2Picker: RyPickerView{
//        let lHolder = RyPickerHolderData(width: .flexible)
//        let listItem1 = RyPickerListData(dataSource: RyIntData.itemsForDateYear, width: .fixed(width:75), defaultIndex: 1)
//        let listItem2 = RyPickerListData(dataSource: RyIntData.itemsForDateMonth, width: .fixed(width:75), defaultIndex: 1)
//        let rHolder = RyPickerHolderData(width: .flexible)
//        let cfg = RyPickerViewConfiguration(title: "日期",
//                                            items: [lHolder,listItem1,listItem2,rHolder])
//        let temp = RyPickerView(dataSource: cfg)
//        let linkerHandler = RyLinkerScrollHandler(configuration: cfg, pickerView: temp)
//        cfg.linkerHandler = linkerHandler
//        return temp
//    }
//
//    static var date3Picker: RyPickerView{
//        let lHolder = RyPickerHolderData(width: .flexible)
//        let listItem1 = RyPickerListData(dataSource: RyIntData.itemsForDateYear, width: .fixed(width:75), defaultIndex: 1)
//        let listItem2 = RyPickerListData(dataSource: RyIntData.itemsForDateMonth, width: .fixed(width:75), defaultIndex: 1)
//        let listItem3 = RyPickerListData(dataSource: RyIntData.itemsForDateDay, width: .fixed(width:75), defaultIndex: 1)
//        let rHolder = RyPickerHolderData(width: .flexible)
//        let cfg = RyPickerViewConfiguration(title: "日期",
//                                            items: [lHolder,listItem1,listItem2,listItem3,rHolder])
//        let temp = RyPickerView(dataSource: cfg)
//        let linkerHandler = RyLinkerScrollHandler(configuration: cfg, pickerView: temp)
//        cfg.linkerHandler = linkerHandler
//        return temp
//    }
//
//    static var timePicker: RyPickerView{
//        let lHolder = RyPickerHolderData(width: .flexible)
//        let listItem1 = RyPickerListData(dataSource: RyIntData.itemsForTimeHoure, width: .fixed(width:75), defaultIndex: 1)
//        let unitItem = RyPickerUnitData(width: .fixed(width:35), unit: ":")
//        let listItem2 = RyPickerListData(dataSource: RyIntData.itemsForTimeMinute, width: .fixed(width:75), defaultIndex: 1)
//        let rHolder = RyPickerHolderData(width: .flexible)
//        let cfg = RyPickerViewConfiguration(title: "时间",
//                                            items: [lHolder,listItem1,unitItem,listItem2, rHolder])
//        let temp = RyPickerView(dataSource: cfg)
//        let linkerHandler = RyLinkerScrollHandler(configuration: cfg, pickerView: temp)
//        cfg.linkerHandler = linkerHandler
//        return temp
//    }
//
//    static var dateTimePicker: RyPickerView{
//        let listItem1 = RyPickerListData(dataSource: RyIntData.itemsForDateAndTimeMonthAndDay, width: .fixed(width:150), defaultIndex: 1)
//        let listItem2 = RyPickerListData(dataSource: RyIntData.itemsForTimeHoure, width: .fixed(width:75), defaultIndex: 1)
//        let unitItem = RyPickerUnitData(width: .fixed(width:35), unit: ":")
//        let listItem3 = RyPickerListData(dataSource: RyIntData.itemsForTimeMinute, width: .flexible, defaultIndex: 1)
//        let cfg = RyPickerViewConfiguration(title: "日期",items: [listItem1,listItem2,unitItem,listItem3])
//        let temp = RyPickerView(dataSource: cfg)
//        let linkerHandler = RyLinkerScrollHandler(configuration: cfg, pickerView: temp)
//        cfg.linkerHandler = linkerHandler
//        return temp
//    }
//
//    static var addressPicker: RyPickerView{
//        let listItem1 = RyPickerListData(dataSource: RyIntData.itemsForAdressProvince, width: .flexible, defaultIndex: 19)
//        let listItem2 = RyPickerListData(dataSource: RyIntData.itemsForAdressCity, width: .flexible, defaultIndex: 1)
//        let listItem3 = RyPickerListData(dataSource: RyIntData.itemsForAdressArea, width: .flexible, defaultIndex: 1)
//        let cfg = RyPickerViewConfiguration(title: "地址",items: [listItem1,listItem2,listItem3])
//        let temp = RyPickerView(dataSource: cfg)
//        let linkerHandler = RyAddressLinkScrollHandler(configuration: cfg, pickerView: temp)
//        cfg.linkerHandler = linkerHandler
//        return temp
//    }
//
    static var weightPicker: RyPickerView{
        var items: [RyPickerViewBaseData] = []
        items.append({
            let intPart = RyPikerRowData.Weight.IntPart
            intPart.forEach({ (thisObj) in
                thisObj.postion = .right(.fixed(width: 75))
            })
            return RyPickerListData(dataSource: intPart,
                                    widthContainer: RyListWidthContainer(.zero, [.flexible, .fixed(width: 75)], .zero))
        }())
        items.append({
            let temp = RyPickerListData(dataSource: RyPikerRowData.Weight.fractionalPart,
                                    widthContainer: RyListWidthContainer(.fixed(width: 35), .fixed(width: 75), .fixed(width: 35)),
                                    inset: RyPickerInset(.zero, .flexible))
            temp.header = "."
            temp.footer = "kg"
            return temp
        }())
        let cfg = RyPickerViewConfiguration(title: "体重",
                                            items: items)
        let temp = RyPickerView(dataSource: cfg)
        return temp
    }

    static var recordMedichinePicker: RyPickerView{
        
        let container = RyListWidthContainer(.zero, .flexible, .zero)
        
        let listItem1 = RyPickerListData(dataSource: RyPikerRowData.itemsForRecordMedichine,
                                         widthContainer: container)
        let listItem2 = RyPickerListData(dataSource: RyPikerRowData.itemsForRecordSKT,
                                         widthContainer: container)
        let listItem3 = RyPickerListData(dataSource: RyPikerRowData.itemsForRecordTimePoint,
                                         widthContainer: container)
        let cfg = RyPickerViewConfiguration(title: "服药记录",items: [listItem1,listItem2,listItem3])
        let temp = RyPickerView(dataSource: cfg)
        return temp
    }
}

class RyPikerRowData: RyLabelCellDataProtocol, RyPickerListable{
    var ryltvc_position: RyLabelTableViewCell.Position{
        return postion
    }
    
    var objInPicker: Any
    
    let rowForObjInPicker: Int
    
    let titleInPicker: String
    
    var ryltvc_title: String{
        return titleInPicker
    }
    
    var identifier: String?
    
    var postion: RyLabelTableViewCell.Position
    
    init(index: Int, title: String, postion: RyLabelTableViewCell.Position = .expand) {
        objInPicker = index
        rowForObjInPicker = index
        self.postion = postion
        self.titleInPicker = title
    }
    
    static var itemsForHeight: [RyPikerRowData]{
        var temp = [RyPikerRowData]()
        for index in 70...250 {
            temp.append(RyPikerRowData(index: index - 69,title: "\(index)"))
        }
        return temp
    }
    
    struct Weight {
        static var IntPart: [RyPikerRowData] {
            var temp = [RyPikerRowData]()
            for index in 20...250 {
                temp.append(RyPikerRowData(index: index - 19,title: "\(index)"))
            }
            return temp
        }
        
        static var fractionalPart: [RyPikerRowData]{
            var temp = [RyPikerRowData]()
            let sequnce = stride(from: 0, to: 10, by: 1)
            for (idx,obj) in sequnce.enumerated() {
                temp.append(RyPikerRowData.init(index: idx, title: String(format: "%d", obj)))
            }
            return temp
        }
    }
    
    static var itemsForEducation:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RyDefualtData.educations.enumerated() {
            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
        }
        return temp
    }
    
    static var itemsForGender:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RyDefualtData.genders.enumerated() {
            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
        }
        return temp
    }
    
    static var itemsForDateYear:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RyDefualtData.Dates.years.enumerated() {
            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
        }
        return temp
    }
    
    static var itemsForDateMonth:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RyDefualtData.Dates.monthes.enumerated() {
            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
        }
        return temp
    }
    
    static var itemsForDateDay:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RyDefualtData.Dates.days.enumerated() {
            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
        }
        return temp
    }
    
    static var itemsForDateAndTimeMonthAndDay:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (idx,obj) in RyDefualtData.Dates.monthes.enumerated() {
            for (index,object) in RyDefualtData.Dates.days.enumerated() {
                temp.append(RyPikerRowData(index: idx * RyDefualtData.Dates.days.count + index + 1,title: "\(obj)-\(object)"))
            }
        }
        return temp
    }
    
    
    static var itemsForTimeHoure:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RyDefualtData.Times.houres.enumerated() {
            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
        }
        return temp
    }
    
    static var itemsForTimeMinute:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RyDefualtData.Times.minutes.enumerated() {
            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
        }
        return temp
    }
    
    static var itemsForAdressProvince:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RyDefualtData.Addresses.provinces.enumerated() {
            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
        }
        return temp
    }
    
    static var itemsForAdressCity:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RyDefualtData.Addresses.cities.enumerated() {
            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
        }
        return temp
    }
    
    static var itemsForAdressArea:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RyDefualtData.Addresses.areas.enumerated() {
            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
        }
        return temp
    }
    
//    static var itemsForRecordMedichine:[RyPikerRowData] {
//        var temp = [RyPikerRowData]()
//        for (index,object) in RyDefualtData.RecordForMedicine.medichines.enumerated() {
//            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
//        }
//        return temp
//    }
//
//    static var itemsForRecordSKT:[RyPikerRowData] {
//        var temp = [RyPikerRowData]()
//        for (index,object) in RyDefualtData.RecordForMedicine.skt.enumerated() {
//            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
//        }
//        return temp
//    }
//
//    static var itemsForRecordTimePoint:[RyPikerRowData] {
//        var temp = [RyPikerRowData]()
//        for (index,object) in RyDefualtData.RecordForMedicine.timePoints.enumerated() {
//            temp.append(RyPikerRowData(index: index + 1,title: "\(object)"))
//        }
//        return temp
//    }
    
}

class RyDefualtData {
   
    static let educations = ["博士或以上","研究生","本科","大专","高中","初中或以下","其他"]
    
    static let genders = ["男","女","其他"]
    
    struct Dates {
        static var components:DateComponents {
            let calendar = Calendar.init(identifier: .gregorian)
            let components = calendar.dateComponents([.year,.month,.day], from: currentDate)
            return components
        }
        
        static var currentDate:Date {
            return Date()
        }
        
        static var year:Int {
            return components.year ?? 2018
        }
        
        static var month:Int {
            return components.month ?? 01
        }
        
        static var day:Int {
            return components.day ?? 01
        }
        
        static var years:[Int] {
            var temp = [Int]()
            for item in stride(from: 1930, to: year + 1, by: 1) {
                temp.append(item)
            }
            return temp
        }
        
        static var monthes:[Int] {
            var temp = [Int]()
            for item in 0...12 {
                temp.append(item)
            }
            return temp
        }
        
        static var days:[Int] {
            var temp = [Int]()
            for item in 0...30 {
                temp.append(item)
            }
            return temp
        }
        
        static func getDays(year:String,month:String) -> Range<Int>? {
            let formatter: DateFormatter = {
                let temp = DateFormatter()
                temp.dateFormat = "yyyy-MM"
                temp.timeZone = TimeZone.current
                return temp
            }()
            let date = formatter.date(from: "\(year)-\(month)") ?? Date()
            return Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: date)
        }
        
    }
    
    struct Times {
        static var houres:[Int] {
            var temp = [Int]()
            for item in 0..<24 {
                temp.append(item)
            }
            return temp
        }
        
        static var minutes:[Int] {
            var temp = [Int]()
            for item in 0..<60 {
                temp.append(item)
            }
            return temp
        }
    }
    
    struct DatesAndTimes {
        static var dates:Dates?
        static var times:Times?
    }
    
    struct Addresses {
        static var defaultDatas:[[String:Any]] {
            let path = Bundle.main.path(forResource: "province", ofType: "json")
            let contents = FileManager.default.contents(atPath: path!)
            let address = try! JSONSerialization.jsonObject(with: contents!, options: JSONSerialization.ReadingOptions.allowFragments)
            return address as! [[String : Any]]
        }
        
        static var provinces:[String] = {
            var temp = [String]()
            for item in defaultDatas {
                temp.append(item["name"] as! String)
            }
            return temp
        }()
        
        static var cities:[String] {
            return getCities()
        }
        
        static var areas:[String] {
            return getArea(city: "深圳市", province: "广东省")
        }
        
        static func getCities(province:String = "广东省") -> [String] {
            var temp = [String]()
            for item in defaultDatas {
                if let provinceItem:String = item["name"] as? String,provinceItem == province {
                    let cityItemes:[[String:Any]] = item["city"] as! [[String:Any]];
                    for cityItem in cityItemes {
                        temp.append(cityItem["name"] as! String)
                    }
                    break
                }
            }
            return temp
        }
        
        static func getArea(city:String = "深圳市" ,province:String = "广东省") -> [String] {
            var temp = [String]()
            for item in defaultDatas {
                if let provinceItem:String = item["name"] as? String,provinceItem == province {
                    let cityItemes:[[String:Any]] = item["city"] as! [[String:Any]];
                    for cityItem in cityItemes {
                        if let currentCity:String = cityItem["name"] as? String , city == currentCity {
                            let areas:[String] = cityItem["area"] as! [String]
                            for areaItem in areas {
                                temp.append(areaItem)
                            }
                            break
                        }
                    }
                }
            }
            return temp
        }
    }
    
    struct RecordForMedicine {
        
        static var medichines = ["唑吡坦(思诺思)","扎来普隆","佐匹克隆","三唑仑","咪达唑仑",
                                 "氟西泮","硝西泮","艾司唑仑","阿普唑仑（佳乐定）","劳拉西泮","度洛西汀（欣百达）",
                                 "帕罗西汀（塞乐特）","奥氮平","美利曲辛（黛利新）", "其他"]
        
        static var skt = ["1/4片","1/3片","1/2片","2/3片","3/4片","1片","1.25片","1.5片",
                          "1.75片","2片","2.25片","2.75片","3片","3.5片","4片","4.5片","5片","5.5片","6片"]
        
        static var timePoints = ["早饭前／后","午饭前／后","晚饭前／后","睡前"]
        
    }
    
}
