//
//  KKAddressPickerModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKAddressPickerModel: KKPickerModel {
    lazy var defaultDatas:[[String:Any]] = {
        let path = Bundle.main.path(forResource: "province", ofType: "json")
        let contents = FileManager.default.contents(atPath: path!)
        let address = try! JSONSerialization.jsonObject(with: contents!, options: JSONSerialization.ReadingOptions.allowFragments)
        return address as! [[String : Any]]
    }()
    
    override var title: String? {
        get {
            return "教育程度"
        }
        set {}
    }
    
    override var datas: [Any]?  {
        get {
            return defaultDatas
        }
        set{
            defaultDatas = newValue as! [[String : Any]]
        }
    }
    
    override var type: SelectorType? {
        get {
            return SelectorType.address
        }
        set {}
    }
    
    
    override func setPickerView() -> (KKPickerSubView) {
        return KKAddressPickerView()
    }
}
