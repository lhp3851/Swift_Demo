//
//  KKStaturePickerView.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKStaturePickerView: KKPickerSubView {

    override var datas: [[String]]! {
        var dataSource = [[String]]()
        let model = KKStaturePickerModel().datas as! [String]
        dataSource.append(model)
        return dataSource
    }


}

