//
//  RyAddressLinkScrollHandler.swift
//  Swift_Demo
//
//  Created by sumian on 2018/12/20.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class RyAddressLinkScrollHandler: RyLinkerScrollBaseHandler {
    //item对应的列,有选中行为
    override func item(_ item: RyPickerViewBaseData, didSelectRow row: Int) {
        guard let cfg = configuration,
              let pickerView = pickerView,
              let index = index(of: item) else {
                return
        }
        guard let selectedObj = item.selectedItem(in: pickerView, inComponent: row) else {
            return
        }
        
        //关于item对应的列的信息：
        //选中的第几行
        let selectedRow = selectedObj.rowForObjInPicker
        //选中的那行的title
        let titleInPicker = selectedObj.titleInPicker
        //选中所关联的对象
        let objInPicker = selectedObj.objInPicker
        
        print(selectedRow,titleInPicker,objInPicker)
        
        if index == 1{
            let todoIndex = index + 1
            let areaes = RyDefualtData.Addresses.getArea(city: titleInPicker, province: "广东省")
            let areaItems = items(from: areaes)
            let newItem = RyPickerListData(dataSource: areaItems, width: .fixed(width:75), defaultIndex: 0)
            cfg.items[todoIndex] = newItem
            newItem.reload(in: pickerView, inComponent: todoIndex)
        }
    }
    
    func items(from:[String]) -> [RyIntData] {
        var temp = [RyIntData]()
        temp.append(RyIntData.last)
        for (index,object) in from.enumerated() {
            temp.append(RyIntData(index: index + 1,title: "\(object)"))
        }
        temp.append(RyIntData.last)
        return temp
    }
    
    
}
