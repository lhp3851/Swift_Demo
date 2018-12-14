//
//  KKGenderPickerView.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKGenderPickerView: KKPickerSubView {
    
    override var datas: [[String]]! {
        get{
            var dataSource = [[String]]()
            let model = KKGenderPickerModel().datas as! [String]
            dataSource.append(model)
            return dataSource
        }
        set{}
    }

}
