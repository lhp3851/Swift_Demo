//
//  RyPickerView + sd.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static var heightPicker: RyPickerView{
        let lHolder = RyPickerHolderData(width: .flexible)
        let listItem = RyPickerListData(dataSource: RyIntData.itemsForHeight, width: .fixed(width:75), defaultIndex: 0)
        let unitItem = RyPickerUnitData(width: .fixed(width:35), unit: "cm")
        let rHolder = RyPickerHolderData(width: .flexible)
        let cfg = RyPickerViewConfiguration(title: "身高",
                                            items: [lHolder,listItem,unitItem,rHolder])
        let temp = RyPickerView(dataSource: cfg)
        let linkerHandler = RyLinkerScrollHandler_Test(configuration: cfg, pickerView: RyPickerView(dataSource: cfg))
        cfg.linkerHandler = linkerHandler
        return temp
    }
    
}

class RyIntData: RyLabelCellDataProtocol, RyPickerListable{
    var objInPicker: Any
    
    let rowForObjInPicker: Int
    
    let titleInPicker: String
    
    var ryltvc_title: String{
        return titleInPicker
    }
    
    var identifier: String?
    
    init(index: Int, title: String) {
        objInPicker = index
        rowForObjInPicker = index
        self.titleInPicker = title
    }
    
    static var itemsForHeight: [RyIntData]{
        var temp = [RyIntData]()
        for index in 70...250 {
            temp.append(RyIntData(index: index,title: "\(index)"))
        }
        return temp
    }
}
