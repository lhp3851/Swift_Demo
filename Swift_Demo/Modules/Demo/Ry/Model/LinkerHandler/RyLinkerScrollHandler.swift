//
//  RyLinkerScrollHandler_Test.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyLinkerScrollHandler: RyLinkerScrollBaseHandler {
    //item对应的列,有选中行为
    override func item(_ item: RyPickerViewBaseData, didSelectRow row: Int) {
        guard let cfg = configuration,
            let pickerView = pickerView,
            let index = index(of: item) else {
            return
        }
        guard let selectedObj = item.selectedItem(in: pickerView, inComponent: index) else {
            return
        }
        
        //index 为 pickerView对应的第几列有选中行为
        
        //关于item对应的列的信息：
        //选中的第几行
        let selectedRow = selectedObj.rowForObjInPicker
        //选中的那行的title
        let titleInPicker = selectedObj.titleInPicker
        //选中所关联的对象
        let objInPicker = selectedObj.objInPicker
//
//        if selectedRow % 3 == 0{
//            let newItem = RyPickerListData(dataSource: RyIntData.itemsForTest, width: .fixed(width:75), defaultIndex: 0)
//            cfg.items[2] = newItem
        //
//        }
    }
}
