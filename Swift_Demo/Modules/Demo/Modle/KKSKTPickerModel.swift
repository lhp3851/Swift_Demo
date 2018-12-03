//
//  KKSKTSelectorModel.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKSKTPickerModel: KKPickerModel {
    static var localDatas = ["","次","元","片","小时","分钟",""]
    
    override var datas: Any? {
        get{
            return KKSKTPickerModel.localDatas
        }
        set{
            KKSKTPickerModel.localDatas = newValue as! [String]
        }
    }
    
    override var type: SelectorType? {
        get{
           return SelectorType.skt
        }
        set{}
    }
    
    override func setPickerView() -> (KKPickerSubView) {
        return KKSKTPickerView.init(frame: CGRect.zero)
    }
}
