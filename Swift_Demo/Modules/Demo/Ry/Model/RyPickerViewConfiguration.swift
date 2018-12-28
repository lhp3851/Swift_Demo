//
//  RyPickerViewConfiguration.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerViewConfiguration:NSObject, RyPickerViewDataSource{
    var items: [RyPickerViewBaseData] = []
    
    var title: String
    
    lazy var totalItemWidths:[RyPickerViewItemWidth] = {
        var temp = [RyPickerViewItemWidth]()
        for thisItem in items {
            let itemPreferredWidth = thisItem.preferredWidthForComponent()
            temp.append(contentsOf: itemPreferredWidth)
        }
        return temp
    }()
    
    init(title: String, items: [RyPickerViewBaseData]) {
        self.title = title
        self.items = items
        super.init()
    }
    
    func numberOfComponents(in pickerView: RyPickerView) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: RyPickerView, widthForComponent component: Int) -> CGFloat {
        let itemPreferredWidth = items[component].preferredWidthForComponent()
        //itemPreferredWidth 只是单个cell希望的宽度
        //实际使用宽度可能不是这个值而是比例，所以可以在此做比例转换
        return itemPreferredWidth.totalWidth(in: pickerView.bounds.width, widths: totalItemWidths)
    }
    
    func pickerView(_ pickerView: RyPickerView, itemViewForComponent component: Int) -> RyPickerItemBaseView{
        let temp = items[component].pickerItemView(at: pickerView.bounds)
        return temp
    }
    
    func titleOfPicker(in pickerView: RyPickerView) -> String? {
        return title
    }
    
    func pickerView(_ pickerView: RyPickerView, widthForItemWidth itemWidth: RyPickerViewItemWidth) -> CGFloat {
        return itemWidth.width(in: pickerView.bounds.width, widths: totalItemWidths)
    }
}
