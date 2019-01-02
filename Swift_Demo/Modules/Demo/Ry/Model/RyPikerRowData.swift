//
//  RyPikerRowData.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/2.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import Foundation


class RyPikerRowData: RyLabelCellDataProtocol, RyPickerListable{
    var objInPicker: Any
    
    let rowForObjInPicker: Int
    
    let titleInPicker: String
    
    var ryltvc_title: String{
        return titleInPicker
    }
    
    var ryltvc_position: RyLabelTableViewCell.Position{
        return postion
    }
    
    var identifier: String?
    
    var postion: RyLabelTableViewCell.Position
    
    init(index: Int, title: String, obj: Any? = nil, postion: RyLabelTableViewCell.Position = .expand) {
        objInPicker = index
        rowForObjInPicker = index
        self.objInPicker = obj ?? index
        self.postion = postion
        self.titleInPicker = title
    }
}
