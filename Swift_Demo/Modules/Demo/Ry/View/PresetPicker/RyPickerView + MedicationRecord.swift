//
//  RyPickerView + MedicationRecord.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/29.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static var medicationRecord: RyPickerView{
        
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

extension RyPikerRowData{
    static var itemsForRecordMedichine:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RecordForMedicine.medichines.enumerated() {
            temp.append(RyPikerRowData(index: index,title: "\(object)"))
        }
        return temp
    }
    
    static var itemsForRecordSKT:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RecordForMedicine.skt.enumerated() {
            temp.append(RyPikerRowData(index: index,title: "\(object)"))
        }
        return temp
    }
    
    static var itemsForRecordTimePoint:[RyPikerRowData] {
        var temp = [RyPikerRowData]()
        for (index,object) in RecordForMedicine.timePoints.enumerated() {
            temp.append(RyPikerRowData(index: index,title: "\(object)"))
        }
        return temp
    }
    
    fileprivate struct RecordForMedicine {
        
        static let medichines = ["唑吡坦(思诺思)","扎来普隆","佐匹克隆","三唑仑","咪达唑仑",
                                 "氟西泮","硝西泮","艾司唑仑","阿普唑仑（佳乐定）","劳拉西泮","度洛西汀（欣百达）",
                                 "帕罗西汀（塞乐特）","奥氮平","美利曲辛（黛利新）", "其他"]
        
        static let skt = ["1/4片","1/3片","1/2片","2/3片","3/4片","1片","1.25片","1.5片",
                          "1.75片","2片","2.25片","2.75片","3片","3.5片","4片","4.5片","5片","5.5片","6片"]
        
        static let timePoints = ["早饭前／后","午饭前／后","晚饭前／后","睡前"]
        
    }
}
