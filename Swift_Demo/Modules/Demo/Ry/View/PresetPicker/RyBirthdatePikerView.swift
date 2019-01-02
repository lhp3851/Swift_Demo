//
//  RyBirthdatePikerView.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/2.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static var birthdate: RyBirthdatePikerView{
        let temp = RyBirthdatePikerView(frame: CGRect.zero)
        temp.selected(titles: ["1980","01"])
        return temp
    }
}

class RyBirthdatePikerView: RyPickerView {
    let birthdateDataSource: RyBirthdatePikerDataSource
    
    init(frame: CGRect) {
        birthdateDataSource = RyBirthdatePikerDataSource()
        super.init(frame: frame, dataSource: birthdateDataSource)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class RyBirthdatePikerDataSource: NSObject, RyPickerContentViewDataSource {
    
    let yearItemView = RyPickerItemListView(frame: CGRect.zero,
                                            widthContainer: RyListWidthContainer(.zero,.flexible,.zero),
                                            inset: RyPickerInset.zero)
    
    let monthItemView = RyPickerItemListView(frame: CGRect.zero,
                                            widthContainer: RyListWidthContainer(.zero,.flexible,.zero),
                                            inset: RyPickerInset.zero)
    
    lazy var itemViews = [yearItemView, monthItemView]
    
    let totalItemWidths:[RyPickerViewItemWidth] = {
        return [.flexible, .flexible]
    }()
    
    override init() {
        super.init()
        for thisItemView in itemViews{
            thisItemView.dataSouce = self
            thisItemView.delegate = self
        }
    }
    
    func numberOfComponents(in pickerView: RyPickerContentView) -> Int {
        return itemViews.count
    }
    
    func pickerView(_ pickerView: RyPickerContentView, widthForComponent component: Int) -> CGFloat {
        return itemViews[component].widthContainer.widths.totalWidth(in: pickerView.bounds.width,
                                                                     widths: totalItemWidths)
    }
    
    func pickerView(_ pickerView: RyPickerContentView, itemViewForComponent component: Int) -> RyPickerItemBaseView {
        return itemViews[component]
    }
    
    func titleOfPicker(in pickerView: RyPickerContentView) -> String? {
        return "出生年月"
    }
    
    func pickerView(_ pickerView: RyPickerContentView, widthForItemWidth itemWidth: RyPickerViewItemWidth) -> CGFloat {
        return itemWidth.width(in: pickerView.bounds.width, widths: totalItemWidths)
    }
    
}

extension RyBirthdatePikerDataSource: RyPickerItemListViewDataSource{
    func numberOfRows(in itemListView: RyPickerItemListView) -> Int {
        if itemListView == yearItemView{
            return RyPikerRowData.itemsForBirthdate.year.count
        }
        if itemListView == monthItemView{
            if yearItemView.selectedObj?.rowForObjInPicker == (RyPikerRowData.itemsForBirthdate.year.count - 1){
                return RyPikerRowData.itemsForBirthdate.currentYearMonthPart.count
            }else{
                return RyPikerRowData.itemsForBirthdate.month.count
            }
        }
        return 0
    }

    func pickerItemListView(_ pickerItemListView: RyPickerItemListView,
                            cellDataForRowAt indexPath: IndexPath) -> RyListItem {
        if pickerItemListView == yearItemView{
            return RyPikerRowData.itemsForBirthdate.year[indexPath.row]
        }
        if pickerItemListView == monthItemView{
            let currentYearMonthPart = RyPikerRowData.itemsForBirthdate.currentYearMonthPart
            if yearItemView.selectedObj?.rowForObjInPicker == (RyPikerRowData.itemsForBirthdate.year.count - 1),
                indexPath.row < currentYearMonthPart.count{
                return RyPikerRowData.itemsForBirthdate.currentYearMonthPart[indexPath.row]
            }else{
                return RyPikerRowData.itemsForBirthdate.month[indexPath.row]
            }
        }
        return RyPikerRowData(index: 0, title: "")
    }
}

extension RyBirthdatePikerDataSource: RyPickerItemBaseViewDelegate{
    func itemBaseView(_ itemBaseView: RyPickerItemBaseView, didSelectRow row: Int, preSelectedRow: RyPickerListable?) {
        if itemBaseView == monthItemView{
            return
        }
        if itemBaseView == yearItemView, yearItemView.selectedObj?.rowForObjInPicker != preSelectedRow?.rowForObjInPicker{
            monthItemView.reload(andFixAtTitle: monthItemView.selectedObj?.titleInPicker)
        }
    }
    
    func itemBaseViewWillBeginDragging(_ itemBaseView: RyPickerItemBaseView) {

    }
    
}

extension RyPikerRowData{
    struct itemsForBirthdate {
        static var year: [RyPikerRowData]{
            var temp = [RyPikerRowData]()
            let currentYear = Calendar.current.component(.year, from: Date())
            for (index, value) in (1920...currentYear).enumerated() {
                let aData = RyPikerRowData(index: index, title: "\(value)", obj: value)
                aData.postion = .right(.fixed(width: 75))
                temp.append(aData)
            }
            return temp
        }
        static var month: [RyPikerRowData]{
            var temp = [RyPikerRowData]()
            for (index, value) in (1...12).enumerated() {
                temp.append(RyPikerRowData(index: index,
                                           title: String(format: "%02d", value),
                                           obj: value,
                                           postion: .left(.fixed(width: 75))))
            }
            return temp
        }
        static var currentYearMonthPart: [RyPikerRowData]{
            var temp = [RyPikerRowData]()
            let currentMonth = Calendar.current.component(.month, from: Date())
            for (index, value) in (1...currentMonth).enumerated() {
                temp.append(RyPikerRowData(index: index,
                                           title: String(format: "%02d", value),
                                           obj: value,
                                           postion: .left(.fixed(width: 75))))
            }
            return temp
        }
    }
}
