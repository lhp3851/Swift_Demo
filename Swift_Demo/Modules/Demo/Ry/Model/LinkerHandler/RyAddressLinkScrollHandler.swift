//
//  RyAddressLinkScrollHandler.swift
//  Swift_Demo
//
//  Created by sumian on 2018/12/20.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class RyAddressLinkScrollHandler: RyLinkerScrollBaseHandler {
    
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
        //关于item对应的列的信息：
        //选中的第几行
        let selectedRow = selectedObj.rowForObjInPicker
        //选中的那行的title
        let titleInPicker = selectedObj.titleInPicker
        //选中所关联的对象
        let objInPicker = selectedObj.objInPicker
        
        print(selectedRow,titleInPicker,objInPicker)
        
        if index == 1{
            changeObjects(pickerView:pickerView ,index: index, objects: selectedObj)
            reloadArea(cfg: cfg, pickerView: pickerView, index: index, title: titleInPicker)
        }
        else if index == 0 {
            changeObjects(pickerView:pickerView ,index: index, objects: selectedObj)
            let city = reloadCity(cfg: cfg, pickerView: pickerView, index: index, title: titleInPicker)
            reloadArea(cfg: cfg, pickerView: pickerView, index: index + 1, title: city)
        }
        else{
            changeObjects(pickerView:pickerView ,index: index, objects: selectedObj)
        }
    }
    
    func items(from:[String]) -> [RyIntData] {
        var temp = [RyIntData]()
        temp.append(RyIntData.first)
        for (index,object) in from.enumerated() {
            temp.append(RyIntData(index: index + 1,title: "\(object)"))
        }
        temp.append(RyIntData.last)
        return temp
    }
    
    func changeObjects(pickerView:RyPickerView, index:Int,objects:RyPickerListable) {
        if selectedOjbs.count > index {
            selectedOjbs[index] = objects
        }
        else{
            selectedOjbs.append(objects)
        }
        pickerView.selectedIndexes[index] = objects.rowForObjInPicker
    }
    
    func reloadCity(cfg:RyPickerViewConfiguration,pickerView:RyPickerView,index:Int,title:String) -> String  {
        let todoIndex = index + 1
        let cities = RyDefualtData.Addresses.getCities(province: title)
        let cityItems = items(from: cities)
        let pickerList:RyPickerListData = cfg.items[todoIndex] as! RyPickerListData
        pickerList.dataSource = cityItems
        pickerList.reload(in: pickerView, inComponent: todoIndex)
        return cities.first ?? ""
    }
    
    func reloadArea(cfg:RyPickerViewConfiguration,pickerView:RyPickerView,index:Int,title:String)  {
        let superSelectedItem = selectedOjbs[index - 1]
        let todoIndex = index + 1
        let areaes = RyDefualtData.Addresses.getArea(city: title, province: superSelectedItem.titleInPicker)
        let areaItems = items(from: areaes)
        let pickerList:RyPickerListData = cfg.items[todoIndex] as! RyPickerListData
        pickerList.dataSource = areaItems
        pickerList.reload(in: pickerView, inComponent: todoIndex)
    }
}
