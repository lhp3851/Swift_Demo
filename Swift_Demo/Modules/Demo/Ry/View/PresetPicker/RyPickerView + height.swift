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
        temp.selected(titles: ["170"])
        return temp
    }
}


extension RyPickerViewConfiguration{
    static var height: RyPickerViewConfiguration{
        let container = RyListWidthContainer(.zero, .flexible, .zero)
        
        let listItem = RyPickerListData(dataSource: RyPikerRowData.itemsForHeight,
                                         widthContainer: container)
        let cfg = RyPickerViewConfiguration(title: "身高",items: [listItem])
        return cfg
    }
}

extension RyPikerRowData{
    static var itemsForHeight: [RyPikerRowData]{
        var temp = [RyPikerRowData]()
        for (index, value) in (30...240).enumerated() {
            temp.append(RyPikerRowData(index: index,title: "\(value)", obj: value))
        }
        return temp
    }
}
