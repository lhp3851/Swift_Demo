//
//  RyPickerView + NightWakeupRecord.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/29.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    
    static var nightWakeupRecord: RyPickerView{
        let cfg = RyPickerViewConfiguration.nightWakeupRecord
        let temp = RyPickerView.init(dataSource: cfg)
        return temp
    }
}

extension RyPickerViewConfiguration{
    static var nightWakeupRecord: RyPickerViewConfiguration{
        let container = RyListWidthContainer(.zero, .flexible, .zero)
        
        let listItem1 = RyPickerListData(dataSource: RyPickerRowData.itemsForWakeupTimes,
                                         widthContainer: container)
        let listItem2 = RyPickerListData(dataSource: RyPickerRowData.itemsForWakeupDuration,
                                         widthContainer: container)
        let cfg = RyPickerViewConfiguration(title: "夜醒次数及总时长",items: [listItem1,listItem2])
        return cfg
    }
}

extension RyPickerRowData{
    fileprivate static var itemsForWakeupTimes:[RyPickerRowData] {
        var temp = [RyPickerRowData]()
        for index in 1...20 {
            temp.append(RyPickerRowData(index: index,title: "\(index)次"))
        }
        return temp
    }
    
    fileprivate static var itemsForWakeupDuration:[RyPickerRowData] {
        var temp = [RyPickerRowData]()
        for (index,duration) in stride(from: 5, through: 360, by: 5).enumerated() {
            let aData = RyPickerRowData(index: index,title: "\(duration)分钟")
            aData.objInPicker = duration
            temp.append(aData)
        }
        return temp
    }
}
