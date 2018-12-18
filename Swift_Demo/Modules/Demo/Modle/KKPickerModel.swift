//
//  KKSelectorModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

/*
 选择器的样式种类：
     1、单列的：性别、教育、入睡时长
     2、两列的：日期、夜醒次数
     3、三列的：日期、地址、服药记录、入睡时长
     4、一列尾加一列固定：身高
     5、两列尾加一列固定：设置提醒时间、起床时间、上床时间
     6、两列加两列固定：体重、入睡时长
     7、三列加一列固定：预约时间
 */

enum SelectorStyle {
    case singleColumn
    case doubleColumn
    case tripleColumn
    case singleColumnAFixedTail
    case doubleColumnAFixedTail
    case doubleColumnAndFixed
    case tripleColumnAFixedLastButOne
}

enum SelectorType : String{
    case education
    case gender
    
    case address
    case date
    case time
    case dateAndTime
    case weight
    case stature
    case skt
    case threeColumn

    case other
}

protocol KKSelectorModelProtocol {
    func setPickerView(model:KKPickerModel) -> (KKPickerSubView)
}

class KKPickerModel: KKBaseModel,KKSelectorModelProtocol {
    //选择器数据
    var datas:[Any]?
    
    //选择器类型
    var type: SelectorType?
    
    //选择器名称
    var title: String? = "选择器"
    
    //单位
    var unit: String?
    
    //是否需要单位
    var needUnit:Bool {
        if let units = unit {
            return !units.isEmpty
        }
        return false
    }
    
    //默认选中的行,以数组的形式提供，因为可能有多列的情况
    var defaultIndex = [1]
    
    //选中的索引
    var selectIndex = IndexPath.init(row: 1, section: 0)
    
    static let groupDatas : [String:[String]] = {
        let datas = ["Selector":["skt","education","gender","stature","address","date","time","dateAndTime","weight","threeColumn"]]
        return datas
    }()
    
    override init() {
        super.init()
    }
    
    init(datas:[Any]) {
        super.init()
        self.datas = datas
    }
    
    func setPickerView(model: KKPickerModel) -> (KKPickerSubView) {
        return KKPickerSubView.init(frame: CGRect.zero, model: KKPickerModel())
    }
}

