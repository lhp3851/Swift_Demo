//
//  RyPickerView + height.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/2.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static var height: RyPickerView{
        let cfg = RyPickerViewConfiguration.height
        let temp = RyPickerView.init(dataSource: cfg)
        temp.unitLabel.text = "cm"
        temp.selected(titles: ["170"])
        return temp
    }
}


extension RyPickerViewConfiguration{
    static var height: RyPickerViewConfiguration{
        let container = RyListWidthContainer(.zero, .flexible, .zero)
        
        let listItem = RyPickerListData(dataSource: RyPickerRowData.itemsForHeight,
                                         widthContainer: container)
        let cfg = RyPickerViewConfiguration(title: "身高",items: [listItem])
        return cfg
    }
}

extension RyPickerRowData{
    static var itemsForHeight: [RyPickerRowData]{
        var temp = [RyPickerRowData]()
        for (index, value) in (30...240).enumerated() {
            let item = RyPickerRowData(index: index,title: "\(value)", obj: value)
            item.postion = .offset(.fixed(width: 17.5), leftOrRight: true)
            temp.append(item)
        }
        return temp
    }
}
