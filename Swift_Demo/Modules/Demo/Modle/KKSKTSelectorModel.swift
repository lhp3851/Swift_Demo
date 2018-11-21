//
//  KKSKTSelectorModel.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKSKTSelectorModel: KKSelectorModel {
    static let datas = ["次","小时","元","片"]
    
    
    override func pickerViewBy(model: Any) -> (UIView.Type) {
        return KKSKTPickerView.self
    }
}
