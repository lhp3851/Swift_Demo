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
        switch itemPreferredWidth {
        case .fixed(let width):
            return width
        case .scale(let factor):
            return pickerView.bounds.width * factor
        case .flexible:
            return flexibleWidth(at: pickerView.bounds)
        }
    }
    
    func flexibleWidth(at bounds: CGRect) -> CGFloat{
        var aWidth = bounds.width
        var count: CGFloat = 0
        for thisItem in items {
            let widthType = thisItem.preferredWidthForComponent(atBounds: bounds)
            if let temp = widthType.width(in: bounds.width){
                aWidth = aWidth - temp
            }else if case .flexible = widthType{
                count = count + 1
            }
        }
        return count > 0 ? (aWidth / count) : 0
    }
    
    func pickerView(_ pickerView: RyPickerView, modelForComponent component: Int) -> RyPickerViewItem {
        return items[component]
    }
    
    func titleOfPicker(in pickerView: RyPickerView) -> String? {
        return title
    }
    
    //处理联动
}
