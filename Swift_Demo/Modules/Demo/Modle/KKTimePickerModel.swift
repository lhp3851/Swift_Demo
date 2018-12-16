//
//  KKTimePickerModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKTimePickerModel: KKPickerModel {
    
    static let share = KKTimePickerModel()
    
    var houres:[String] = ["","00","01","02","03","04",
                           "05","06","07","08","09","10",
                           "11","12","13","14","15","16",
                           "17","18","19","20","21","22",
                           "23","24",""]
    
    var minutes:[String] = ["","00","01","02","03","04",
                            "05","06","07","08","09","10",
                            "11","12","13","14","15","16",
                            "17","18","19","20","21","22",
                            "23","24","25","26","27","28",
                            "29","30","31","32","33","34",
                            "35","36","37","38","39","40",
                            "41","42","43","44","45","46",
                            "47","48","49","50","51","52",
                            "53","54","55","56","57","58",
                            "59",""]
    
    var defaltDatas:[[String]]  {
        get {
            var temp = [[String]]()
            temp.append(houres)
            temp.append(minutes)
            return temp
        }
        set {}
    }
    
    
    override var datas: [Any]? {
        get{
            return defaltDatas
        }
        set{
            defaltDatas = newValue as! [[String]]
        }
    }
    
    override var title: String?{
        get {
            return "时间"
        }
        set {}
    }
    
    override var type: SelectorType?{
        get {
            return SelectorType.time
        }
        set {}
    }
    
}
