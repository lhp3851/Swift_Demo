//
//  RyPikerView + NapRecord.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/29.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static var napRecord: RyPickerView{
        let cfg = RyPickerViewConfiguration.napRecord
        cfg.title = "白天小睡次数及总时长"
        let temp = RyPickerView.init(dataSource: cfg)
        return temp
    }
}

extension RyPickerViewConfiguration{
    static var napRecord: RyPickerViewConfiguration{
        return nightWakeupRecord
    }
}
