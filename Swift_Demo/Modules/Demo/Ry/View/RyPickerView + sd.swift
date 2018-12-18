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
        let listItem = RyPickerListData(dataSource: RyLabelData.itemsForHeight, width: .fixed(width:75), defaultIndex: 0)
        let unitItem = RyPickerUnitData(width: .fixed(width:35), unit: "cm")
        let rHolder = RyPickerHolderData(width: .flexible)
        let cfg = RyPickerViewConfiguration(title: "身高", items: [lHolder,listItem,unitItem,rHolder])
        return RyPickerView(dataSource: cfg)
    }
    
}

fileprivate class RyLabelData: RyLabelCellDataProtocol {
    var ryltvc_title: String
    
    var identifier: String?
    
    init(title: String) {
        self.ryltvc_title = title
    }
    
    static var itemsForHeight: [RyLabelData]{
        var temp = [RyLabelData]()
        for index in 70..<220 {
            temp.append(RyLabelData(title: "\(index)"))
        }
        temp.insert(RyLabelData(title: ""), at: 0)
        temp.append(RyLabelData(title: ""))
        return temp
    }
}
