//
//  KKSKTSelectorModel.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKSKTPickerModel: KKPickerModel {
    static var localDatas = ["次","小时","元","片"]
    
    override var datas: Any? {
        get{
            return KKSKTPickerModel.localDatas
        }
        set{}
    }
    
    override var type: SelectorType? {
        get{
           return SelectorType.skt
        }
        set{}
    }
    
    override func setPickerView() -> (KKPickerSubView) {
        return KKColumnsPickerView.init(frame: CGRect.zero, component: 0)
    }
}
