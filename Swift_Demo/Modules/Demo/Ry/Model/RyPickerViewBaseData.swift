//
//  RyPickerViewBaseData.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerViewBaseData: NSObject {
    
    weak var itemScrollDelegate: RyPickerViewItemScrollDelegate?

    var type: RyPickerViewItemType{
        return .holder
    }
    
    var component: Int = 0
    
    var selectIndex: Int{
        return 0
    }
    
    func preferredWidthForComponent() -> [RyPickerViewItemWidth]{
        return []
    }
    
    func reload(){
        
    }
    
    func selectedItem() -> RyPickerListable{
        return HolderListData(row: 0)
    }
    
    func pickerItemView(at bounds: CGRect) -> RyPickerItemBaseView{
        return RyPickerItemBaseView(frame: bounds)
    }
    
    private struct HolderListData: RyPickerListable{
        var objInPicker: Any
        
        var rowForObjInPicker: Int
        
        var titleInPicker: String
        
        init(row: Int) {
            self.objInPicker = row
            self.titleInPicker = ""
            self.rowForObjInPicker = row
        }
    }
}


