//
//  RyPickerView + weight.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/2.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static var weight: RyPickerView{
        let cfg = RyPickerViewConfiguration.weight
        let temp = RyPickerView.init(dataSource: cfg)
        temp.selected(titles: ["50","0"])
        return temp
    }
}

extension RyPickerViewConfiguration{
    static var weight: RyPickerViewConfiguration{
        var items: [RyPickerViewBaseData] = []
        items.append({
            let intPart = RyPickerRowData.itemsForWeight.integer
            intPart.forEach({ (thisObj) in
                thisObj.postion = .right(.fixed(width: 75))
            })
            return RyPickerListData(dataSource: intPart,
                                    widthContainer: RyListWidthContainer(.zero, [.flexible, .fixed(width: 75)], .zero))
            }())
        items.append({
            let temp = RyPickerListData(dataSource: RyPickerRowData.itemsForWeight.fractional,
                                        widthContainer: RyListWidthContainer(.fixed(width: 35), .fixed(width: 75), .fixed(width: 35)),
                                        inset: RyPickerInset(.zero, .flexible))
            temp.header = "."
            temp.footer = "kg"
            return temp
            }())
        let cfg = RyPickerViewConfiguration(title: "体重",
                                            items: items)
        return cfg
    }
}

extension RyPickerRowData{
    struct itemsForWeight {
        static var integer: [RyPickerRowData] {
            var temp = [RyPickerRowData]()
            for (index, value) in (20...200).enumerated() {
                temp.append(RyPickerRowData(index: index, title: "\(value)", obj: value))
            }
            return temp
        }
        
        static var fractional: [RyPickerRowData]{
            var temp = [RyPickerRowData]()
            for (index, value) in (0...9).enumerated() {
                temp.append(RyPickerRowData(index: index, title: "\(value)", obj: value))
            }
            return temp
        }
    }
}
