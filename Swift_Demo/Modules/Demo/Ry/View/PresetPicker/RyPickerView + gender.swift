//
//  RyPickerView + gender.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/2.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import UIKit
//gender

enum RyGenderType: String {
    case secrecy = "secrecy"
    case male    = "male"
    case female  = "female"
    
    var description : String {
        switch self {
        case .secrecy: return "保密";
        case .male: return "男";
        case .female: return "女";
        }
    }
    
    var description2 : String {
        switch self {
        case .secrecy:
            return "未填写"
        case .male, .female:
            return description
        }
    }
}

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
        
        let listItem = RyPickerListData(dataSource: RyPikerRowData.itemsForGender,
                                        widthContainer: container)
        let cfg = RyPickerViewConfiguration(title: "性别",items: [listItem])
        return cfg
    }
}


extension RyPikerRowData{
    static var itemsForGender: [RyPikerRowData]{
        var temp = [RyPikerRowData]()
        let items = [RyGenderType.male, RyGenderType.female]
        for (index, value) in items.enumerated() {
            temp.append(RyPikerRowData(index: index,title: value.description, obj: value))
        }
        return temp
    }
}
