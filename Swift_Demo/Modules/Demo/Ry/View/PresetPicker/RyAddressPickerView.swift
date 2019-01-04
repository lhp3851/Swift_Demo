//
//  RyAddressPickerView.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/2.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static var address: RyAddressPickerView{
        return RyAddressPickerView(frame: CGRect.zero)
    }
}

class RyAddressPickerView: RyPickerView {

    let addressDataSource: RyAddressPickerDataSource
    
    init(frame: CGRect) {
        addressDataSource = RyAddressPickerDataSource()
        super.init(frame: frame, dataSource: addressDataSource)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RyAddressPickerDataSource: NSObject, RyPickerContentViewDataSource {
    
    let provincesItemView = RyPickerItemListView(frame: CGRect.zero,
                                                 widthContainer: RyListWidthContainer(.zero,.flexible,.zero),
                                                 inset: .zero)
    
    let cityItemView = RyPickerItemListView(frame: CGRect.zero,
                                            widthContainer: RyListWidthContainer(.zero,.flexible,.zero),
                                            inset: .zero)
    
    let areaItemView = RyPickerItemListView(frame: CGRect.zero,
                                            widthContainer: RyListWidthContainer(.zero,.flexible,.zero),
                                            inset: .zero)
    
    lazy var itemViews = [provincesItemView, cityItemView, areaItemView]
    
    let totalItemWidths:[RyPickerViewItemWidth] = {
        return [.flexible, .flexible, .flexible]
    }()
    
    override init() {
        super.init()
        for thisItemView in itemViews{
            thisItemView.dataSouce = self
            thisItemView.delegate = self
        }
    }
    
    func numberOfComponents(in pickerView: RyPickerContentView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: RyPickerContentView, widthForComponent component: Int) -> CGFloat {
        return [.flexible].totalWidth(in: pickerView.bounds.width, widths: totalItemWidths)
    }
    
    func pickerView(_ pickerView: RyPickerContentView, itemViewForComponent component: Int) -> RyPickerItemBaseView {
        return itemViews[component]
    }
    
    func titleOfPicker(in pickerView: RyPickerContentView) -> String? {
        return "地址"
    }
    
    func pickerView(_ pickerView: RyPickerContentView, widthForItemWidth itemWidth: RyPickerViewItemWidth) -> CGFloat {
        return itemWidth.width(in: pickerView.bounds.width, widths: totalItemWidths)
    }
}

extension RyAddressPickerDataSource: RyPickerItemListViewDataSource{
    func numberOfRows(in itemListView: RyPickerItemListView) -> Int {
        if itemListView == provincesItemView{
            return RyPickerRowData.Addresses.provinces.count
        }
        
        if itemListView == cityItemView, let p = provincesItemView.selectedObj?.titleInPicker{
            return RyPickerRowData.Addresses.getCities(province: p).count
        }
        
        if itemListView == areaItemView,
            let p = provincesItemView.selectedObj?.titleInPicker,
            let c = cityItemView.selectedObj?.titleInPicker{
            return RyPickerRowData.Addresses.getArea(city: c, province: p).count
        }
        return 0
    }
    
    func pickerItemListView(_ pickerItemListView: RyPickerItemListView,
                            cellDataForRowAt indexPath: IndexPath) -> RyListItem {
        var value = String()
        if pickerItemListView == provincesItemView{
            value = RyPickerRowData.Addresses.provinces[indexPath.row]
        }
        
        if pickerItemListView == cityItemView, let p = provincesItemView.selectedObj?.titleInPicker{
            let city = RyPickerRowData.Addresses.getCities(province: p)
            if indexPath.row < city.count{
                value = city[indexPath.row]
            }
        }
        
        if pickerItemListView == areaItemView,
            let p = provincesItemView.selectedObj?.titleInPicker,
            let c = cityItemView.selectedObj?.titleInPicker{
            let area = RyPickerRowData.Addresses.getArea(city: c, province: p)
            if indexPath.row < area.count{
                value = area[indexPath.row]
            }
        }
        let item = RyPickerRowData(index: indexPath.row, title: value, obj: value)
        return item
    }
    
}

extension RyAddressPickerDataSource: RyPickerItemBaseViewDelegate{
    func itemBaseView(_ itemBaseView: RyPickerItemBaseView, didSelectRow row: Int, preSelectedRow: RyPickerListable?) {
        if itemBaseView == areaItemView{
            return
        }
        
        if itemBaseView == provincesItemView,provincesItemView.selectedObj?.rowForObjInPicker != preSelectedRow?.rowForObjInPicker{
            cityItemView.reload(andFixAtTitle: cityItemView.selectedObj?.titleInPicker)
            areaItemView.reload(andFixAtTitle: areaItemView.selectedObj?.titleInPicker)
        }
        
        if itemBaseView == cityItemView, cityItemView.selectedObj?.rowForObjInPicker != preSelectedRow?.rowForObjInPicker{
            areaItemView.reload(andFixAtTitle: areaItemView.selectedObj?.titleInPicker)
        }
    }
    
    func itemBaseViewWillBeginDragging(_ itemBaseView: RyPickerItemBaseView) {
        
    }
}

extension RyPickerRowData{
    struct itemsForAddresses {
        static var provinces: [RyPickerRowData] = {
            var temp = [RyPickerRowData]()
            for (index, value) in Addresses.provinces.enumerated() {
                temp.append(RyPickerRowData(index: index, title: value, obj: value))
            }
            return temp
        }()
        
        static var city: [RyPickerRowData] = {
            var temp = [RyPickerRowData]()
            for (index, value) in Addresses.cities.enumerated() {
                temp.append(RyPickerRowData(index: index, title: value, obj: value))
            }
            return temp
        }()
        
        static var area: [RyPickerRowData] = {
            var temp = [RyPickerRowData]()
            for (index, value) in Addresses.areas.enumerated() {
                temp.append(RyPickerRowData(index: index, title: value, obj: value))
            }
            return temp
        }()
    }
    
    struct Addresses {
        static var defaultDatas:[[String:Any]] = {
            let path = Bundle.main.path(forResource: "province", ofType: "json")
            let contents = FileManager.default.contents(atPath: path!)
            let address = try! JSONSerialization.jsonObject(with: contents!, options: JSONSerialization.ReadingOptions.allowFragments)
            return address as! [[String : Any]]
        }()
        
        static var provinces:[String] = {
            var temp = [String]()
            for item in defaultDatas {
                temp.append(item["name"] as! String)
            }
            return temp
        }()
        
        static var cities:[String] {
            return getCities()
        }
        
        static var areas:[String] {
            return getArea(city: "北京市", province: "北京市")
        }
        
        static func getCities(province:String = "北京市") -> [String] {
            var temp = [String]()
            for item in defaultDatas {
                if let provinceItem:String = item["name"] as? String,provinceItem == province {
                    let cityItemes:[[String:Any]] = item["city"] as! [[String:Any]];
                    for cityItem in cityItemes {
                        temp.append(cityItem["name"] as! String)
                    }
                    break
                }
            }
            return temp
        }
        
        static func getArea(city:String = "深圳市" ,province:String = "广东省") -> [String] {
            var temp = [String]()
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
            return temp
        }
    }
}
