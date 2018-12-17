//
//  KKSKTSelectorModel.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKSKTPickerModel: KKPickerModel {
    
    static let share = KKSKTPickerModel()
    
    static var defaultDatas = [["","次","元","片","小时","分钟",""]]
    
    override var datas: [Any]? {
        get{
            return KKSKTPickerModel.defaultDatas
        }
        set{
            KKSKTPickerModel.defaultDatas = [newValue as! [String]]
        }
    }
    
    override var type: SelectorType? {
        get{
           return SelectorType.skt
        }
        set{}
    }
    
    override var defaultIndex: [Int] {
        get {
            return [0,0,0]
        }
        set {}
    }
    
    override func setPickerView(model: KKPickerModel) -> (KKPickerSubView) {
        return KKSKTPickerView.init(frame: CGRect.zero, model: model)
    }
}
