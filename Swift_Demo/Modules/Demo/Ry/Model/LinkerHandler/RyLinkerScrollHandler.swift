//
//  RyLinkerScrollHandler_Test.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyLinkerScrollHandler: RyLinkerScrollBaseHandler {
    
    var selectedOjbs:[RyPickerListable] = []
    
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
        
        changeObjects(pickerView:pickerView,index: index, objects: selectedObj)
    }
    
    func changeObjects(pickerView:RyPickerView,index:Int,objects:RyPickerListable) {
        if selectedOjbs.count > index {
            selectedOjbs[index] = objects
        }
        else{
            selectedOjbs.append(objects)
        }
        pickerView.selectedIndexes[index] = objects.rowForObjInPicker
    }
}
