//
//  RyDatePickerView.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/29.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static func date(startDate: Date, endDate: Date) -> RyPickerView{
        return RyDatePickerView(frame: CGRect.zero, startDate: startDate, endDate: endDate)
    }
}

class RyDatePickerView: RyPickerView {
    
    let dateDataSource: RyDatePickerDataSource
    
    init(frame: CGRect, startDate: Date, endDate: Date) {
        dateDataSource = RyDatePickerDataSource(startDate: startDate, endDate: endDate)
        super.init(frame: frame, dataSource: dateDataSource)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class RyDatePickerDataSource:NSObject, RyPickerContentViewDataSource {
    
    var startDate: Date
    
    var endDate: Date
    
    
    private(set) var selectedMinute: Int?
    
    let hourItemView: RyPickerItemListView = {
        let temp = RyPickerItemListView(frame: CGRect.zero,
                                        widthContainer: RyListWidthContainer(.zero,
                                                                             [.flexible, .fixed(width: 75)],
                                                                             .fixed(width: 35)),
                                        inset: .zero)
        temp.footerLabel.text = ":"
        return temp
    }()
    
    let minuteItemView = RyPickerItemListView(frame: CGRect.zero,
                                            widthContainer: RyListWidthContainer(.zero,
                                                                                 [.flexible, .fixed(width: 75)],
                                                                                 .zero),
                                            inset: .zero)
    
    lazy var totalItemWidths:[RyPickerViewItemWidth] = {
        var temp = hourItemView.widthContainer.widths
        temp.append(contentsOf: minuteItemView.widthContainer.widths)
        return temp
    }()
    
    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        selectedMinute = Calendar.current.component(.minute, from: startDate)
        super.init()
        hourItemView.dataSouce = self
        hourItemView.delegate = self
        minuteItemView.dataSouce = self
        minuteItemView.delegate = self
    }
    
    func numberOfComponents(in pickerView: RyPickerContentView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: RyPickerContentView, widthForComponent component: Int) -> CGFloat {
        if component == 0{
            return hourItemView.widthContainer.widths.totalWidth(in: pickerView.bounds.width, widths: totalItemWidths)
        }
        return minuteItemView.widthContainer.widths.totalWidth(in: pickerView.bounds.width, widths: totalItemWidths)
    }
    
    func pickerView(_ pickerView: RyPickerContentView, itemViewForComponent component: Int) -> RyPickerItemBaseView {
        if component == 0{
            return hourItemView
        }else{
            return minuteItemView
        }
    }
    
    func titleOfPicker(in pickerView: RyPickerContentView) -> String? {
        return nil
    }
    
    func pickerView(_ pickerView: RyPickerContentView, widthForItemWidth itemWidth: RyPickerViewItemWidth) -> CGFloat {
        return itemWidth.width(in: pickerView.bounds.width, widths: totalItemWidths)
    }
    
}


extension RyDatePickerDataSource: RyPickerItemListViewDataSource{
    var zeroStartDate: Date{
        let hour = Calendar.current.component(.hour, from: startDate)
        return Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: startDate)!
    }
    
    var zeroEndDate: Date{
        let hour = Calendar.current.component(.hour, from: endDate)
        return Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: endDate)!
    }
    
    func numberOfRows(in itemListView: RyPickerItemListView) -> Int {
        if itemListView == hourItemView{
            let temp = Calendar.current.dateComponents([.hour, .minute], from: zeroStartDate, to: zeroEndDate)
            var hour = temp.hour ?? 0
            if Calendar.current.component(.minute, from: endDate) > 0{
                hour = hour + 1
            }
            return hour
        }
        guard let hourDate = hourItemView.selectedObj?.objInPicker as? Date else{
            return 12
        }
        var start = 0
        var end = 55
        if Calendar.current.compare(hourDate, to: startDate, toGranularity: Calendar.Component.hour) == .orderedSame{
            start = Calendar.current.component(Calendar.Component.minute, from: startDate)
        }
        
        if Calendar.current.compare(hourDate, to: endDate, toGranularity: Calendar.Component.hour) == .orderedSame{
            end = Calendar.current.component(Calendar.Component.minute, from: endDate)
        }
        let num = (end - start)/5 + 1
        print("num \(num)")
        return num
    }
    
    func pickerItemListView(_ pickerItemListView: RyPickerItemListView,
                            cellDataForRowAt indexPath: IndexPath) -> RyListItem{
        if pickerItemListView == hourItemView{
            let temp = Calendar.current.date(byAdding: .hour,
                                             value: indexPath.row,
                                             to: startDate) ?? startDate
            let hour = Calendar.current.component(Calendar.Component.hour, from: temp)
            let item = RyPikerRowData(index: indexPath.row, title: "\(hour)")
            item.objInPicker = temp
            item.postion = .right(RyPickerViewItemWidth.fixed(width: 75))
            return item
        }
        guard let hourDate = hourItemView.selectedObj?.objInPicker as? Date else{
            return RyPikerRowData(index: 0, title: "-")
        }
        
        var markDate = zeroStartDate
        if Calendar.current.compare(hourDate, to: startDate, toGranularity: Calendar.Component.hour) == .orderedSame{
            markDate = startDate
        }
        
        let temp = Calendar.current.date(byAdding: .minute,
                                         value: indexPath.row * 5,
                                         to: markDate) ?? markDate
        let minute = Calendar.current.component(.minute, from: temp)
        let item = RyPikerRowData(index: indexPath.row, title: "\(minute)")
        item.objInPicker = temp
        item.postion = .left(RyPickerViewItemWidth.fixed(width: 75))
        return item
    }
}


extension RyDatePickerDataSource: RyPickerItemBaseViewDelegate{
    func itemBaseViewWillBeginDragging(_ itemBaseView: RyPickerItemBaseView) {
        if itemBaseView != hourItemView{
            return
        }
        if let temp = minuteItemView.selectedObj?.objInPicker as? Date{
            selectedMinute = Calendar.current.component(.minute, from: temp)
        }else{
            selectedMinute = nil
        }
    }
    
    func itemBaseView(_ itemBaseView: RyPickerItemBaseView, didSelectRow row: Int, preSelectedRow: RyPickerListable?) {
        print("didSelectRow \(row)")
        if row == preSelectedRow?.rowForObjInPicker{
            return
        }

        if itemBaseView == hourItemView{
            var title: String? = nil

            if let selectedMinute = selectedMinute{
                title = "\(selectedMinute)"
            }
            minuteItemView.reload(andFixAtTitle: title)
        }

    }
}
