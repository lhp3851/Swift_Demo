//
//  RyLinkerScrollBaseHandler.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyLinkerScrollBaseHandler: NSObject, RyPickerViewItemScrollDelegate {
    
    private(set) weak var configuration: RyPickerViewConfiguration?
    
    private(set) var pickerView: RyPickerView?
    
    init(configuration: RyPickerViewConfiguration, pickerView: RyPickerView) {
        self.configuration = configuration
        self.pickerView = pickerView
    }
    
    func item(_ item: RyPickerViewBaseData, didSelectRow row: Int){
       //Do Nothing
    }
    
    
    func index(of item: RyPickerViewBaseData) -> Int?{
        guard let configuration = configuration else {
            return nil
        }
        let items = configuration.items
        for (index,thisItem) in items.enumerated() {
            if ObjectIdentifier(thisItem) > ObjectIdentifier(item){
                return index
            }
        }
        return nil
    }
}
