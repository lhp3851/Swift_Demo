//
//  RyPikerRowData.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/2.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import UIKit


class RyPickerRowData: RyPickerListable{
    var objInPicker: Any
    
    let rowForObjInPicker: Int
    
    let titleInPicker: String
    
    var identifier: String?
    
    var postion: RyLabelTableViewCell.Position
    
    var cellType: (UITableViewCell & RyCellProtocol).Type
    
    init(index: Int, title: String, obj: Any? = nil,
         postion: RyLabelTableViewCell.Position = .expand,
         cellType: (UITableViewCell & RyCellProtocol).Type = RyLabelTableViewCell.self) {
        objInPicker = index
        rowForObjInPicker = index
        self.cellType = cellType
        self.objInPicker = obj ?? index
        self.postion = postion
        self.titleInPicker = title
    }
}

extension RyPickerRowData:RyLabelCellDataProtocol, RyRoundLabelCellDataProtocol{
    var ryltvc_title: String{
        return titleInPicker
    }
    
    var ryltvc_position: RyLabelTableViewCell.Position{
        return postion
    }
    
    func cellType(userInfo: [String : Any]?) -> (UITableViewCell & RyCellProtocol).Type {
        return cellType
    }
}
