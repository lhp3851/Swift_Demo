//
//  RyPickerViewConfiguration.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerViewConfiguration: RyPickerViewDataSource{
    var items: [RyPickerViewItem] = []
    
    var title: String
    
    init(title: String, items: [RyPickerViewItem]) {
        self.title = title
        self.items = items
    }
    
    func numberOfComponents(in pickerView: RyPickerView) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: RyPickerView, widthForComponent component: Int) -> CGFloat {
        let item = items[component]
        let itemPreferredWidth = item.preferredWidthForComponent(atBounds: pickerView.bounds)
        //itemPreferredWidth 只是单个cell希望的宽度
        //实际使用宽度可能不是这个值而是比例，所以可以在此做比例转换
        return itemPreferredWidth
    }
    
    func pickerView(_ pickerView: RyPickerView, modelForComponent component: Int) -> RyPickerViewItem {
        return items[component]
    }
    
    func titleOfPicker(in pickerView: RyPickerView) -> String? {
        return title
    }
    
    //处理联动
}
