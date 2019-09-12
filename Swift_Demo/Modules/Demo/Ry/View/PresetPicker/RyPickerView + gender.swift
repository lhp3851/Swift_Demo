//
//  RyPickerView + gender.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/2.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static var gender: RyPickerView{
        let cfg = RyPickerViewConfiguration.gender
        let temp = RyPickerView.init(dataSource: cfg)
        return temp
    }
}

extension RyPickerViewConfiguration{
    static var gender: RyPickerViewConfiguration{
        let container = RyListWidthContainer(.zero, .flexible, .zero)
        
        let listItem = RyPickerListData(dataSource: RyPickerRowData.itemsForGender,
                                        widthContainer: container)
        let cfg = RyPickerViewConfiguration(title: "性别",items: [listItem])
        return cfg
    }
}


extension RyPickerRowData{
    static var itemsForGender: [RyPickerRowData]{
        var temp = [RyPickerRowData]()
        let items = [RyGenderType.male, RyGenderType.female]
        for (index, value) in items.enumerated() {
            temp.append(RyPickerRowData(index: index,title: value.description, obj: value))
        }
        return temp
    }
}
