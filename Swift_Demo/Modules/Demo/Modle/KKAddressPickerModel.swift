//
//  KKAddressPickerModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKAddressPickerModel: KKPickerModel {
    
    static let share = KKAddressPickerModel()
    
    lazy var defaultDatas:[[String:Any]] = {
        let path = Bundle.main.path(forResource: "province", ofType: "json")
        let contents = FileManager.default.contents(atPath: path!)
        let address = try! JSONSerialization.jsonObject(with: contents!, options: JSONSerialization.ReadingOptions.allowFragments)
        return address as! [[String : Any]]
    }()
    
    lazy var provinces:[String] = {
        var temp = [String]()
        temp.append("")
        for item in defaultDatas {
            temp.append(item["name"] as! String)
        }
        temp.append("")
        return temp
    }()
    
    var cities:[String] {
        return getCities()
    }
    
    var area:[String] {
        return getArea(city: "深圳市", province: "广东省")
    }
    
    override var title: String? {
        get {
            return "地址"
        }
        set {}
    }
    
    override var datas: [Any]?  {
        get {
            var temp = [[String]]()
            temp.append(provinces)
            temp.append(cities)
            temp.append(area)
            return temp
        }
        set{
            
        }
    }
    
    override var type: SelectorType? {
        get {
            return SelectorType.address
        }
        set {}
    }
    
    override var defaultIndex: [Int] {
        get {
            let provinceIndex = self.provinces.indices(of: "广东省")
            let cityIndex = self.cities.indices(of: "深圳市")
            let areaIndex = self.area.indices(of: "宝安区")
            return [provinceIndex.first ?? 1,cityIndex.first ?? 1,areaIndex.first ?? 1]
        }
        set {}
    }
    
    func getCities(province:String = "广东省") -> [String] {
        var temp = [String]()
        temp.append("")
        for item in defaultDatas {
            if let provinceItem:String = item["name"] as? String,provinceItem == province {
                let cityItemes:[[String:Any]] = item["city"] as! [[String:Any]];
                for cityItem in cityItemes {
                    temp.append(cityItem["name"] as! String)
                }
                break
            }
        }
        temp.append("")
        return temp
    }
    
    func getArea(city:String = "深圳市" ,province:String = "广东省") -> [String] {
        var temp = [String]()
        temp.append("")
        for item in defaultDatas {
            if let provinceItem:String = item["name"] as? String,provinceItem == province {
                let cityItemes:[[String:Any]] = item["city"] as! [[String:Any]];
                for cityItem in cityItemes {
                    if let currentCity:String = cityItem["name"] as? String , city == currentCity {
                        let areas:[String] = cityItem["area"] as! [String]
                        for areaItem in areas {
                            temp.append(areaItem)
                        }
                        break
                    }
                }
            }
        }
        temp.append("")
        return temp
    }
    
    override func setPickerView(model: KKPickerModel) -> (KKPickerSubView) {
        return KKAddressPickerView.init(frame: CGRect.zero, model: model)
    }
}
