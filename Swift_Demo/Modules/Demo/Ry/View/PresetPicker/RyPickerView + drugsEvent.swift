//
//  RyPickerView + drugsEver.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/2.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static var drugsEver: RyPickerView{
        let titles = ["有服用","没有"]
        let temp = RyPickerView.picker(with: titles, pickerTitle: "当前是否服用促进睡眠类药物？")
        return temp
    }
}
