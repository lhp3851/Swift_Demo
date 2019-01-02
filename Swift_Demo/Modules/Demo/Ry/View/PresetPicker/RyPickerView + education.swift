//
//  RyPickerView + education.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/2.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static var education: RyPickerView{
        let cfg = RyPickerViewConfiguration.education
        let temp = RyPickerView.init(dataSource: cfg)
        temp.selected(titles: ["大专"])
        return temp
    }
}

extension RyPickerViewConfiguration{
    static var education: RyPickerViewConfiguration{
        let container = RyListWidthContainer(.zero, .flexible, .zero)
        
        let listItem = RyPickerListData(dataSource: RyPikerRowData.itemsForEducation,
                                        widthContainer: container)
        let cfg = RyPickerViewConfiguration(title: "教育程度",items: [listItem])
        return cfg
    }
}

extension RyPikerRowData{
    static var itemsForEducation: [RyPikerRowData]{
        var temp = [RyPikerRowData]()
        let educations = ["博士或以上","研究生","本科","大专","高中","初中或以下","其他"]
        for (index, value) in educations.enumerated() {
            temp.append(RyPikerRowData(index: index,title: value, obj: value))
        }
        return temp
    }
}
