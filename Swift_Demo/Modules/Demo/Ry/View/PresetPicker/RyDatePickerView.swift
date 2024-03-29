//
//  RyDatePickerView.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/29.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    static func date(startDate: Date, endDate: Date) -> RyDatePickerView{
        return RyDatePickerView(frame: CGRect.zero, startDate: startDate, endDate: endDate)
    }
}

class RyDatePickerView: RyPickerView {
    
    let dateDataSource: RyDatePickerDataSource
    
    init(frame: CGRect, startDate: Date, endDate: Date) {
        dateDataSource = RyDatePickerDataSource(startDate: startDate, endDate: endDate)
        super.init(frame: frame, dataSource: dateDataSource)
        symbolItem.pickerItemView.layoutDelegate = self
    }
    
    func reload(andFixAtDate date: Date) {
        dateDataSource.reload(andFixAtDate: date)
    }
    
    override func selected(titles: [String]) {
        if titles.count >= 1{
            dateDataSource.hourItemView.reload(andFixAtTitle: titles[0])
        }
        if titles.count >= 2{
            dateDataSource.minuteItemView.reload(andFixAtTitle: titles[1])
        }
    }
    
    override func selected(indexs: [Int]) {
        if indexs.count >= 1{
            dateDataSource.hourItemView.reload(andFixAtIndex: indexs[0])
        }
        if indexs.count >= 2{
            dateDataSource.minuteItemView.reload(andFixAtIndex: indexs[1])
        }
    }
    
    override func setupSubview() {
        super.setupSubview()
        contentView.addSubview(symbolItem.pickerItemView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let itemWidth = symbolItem.pickerItemView.widthForItemWidth(symbolItem.preferredWidthForComponent())
        symbolItem.pickerItemView.frame = CGRect(x: 0, y: 0, width: itemWidth, height: contentView.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var symbolItem: RyPickerListData {
        return dateDataSource.symbolItem
    }
}


protocol RyDatePickerSourceDelegate: NSObjectProtocol {
    func datePickerDataSource(_ dataSoure: RyDatePickerDataSource,
                              didSelectedDateChanged selectedDate: Date)
}

class RyDatePickerDataSource:NSObject, RyPickerContentViewDataSource {
    
    var startDate: Date
    
    var endDate: Date
    
    weak var delegate: RyDatePickerSourceDelegate?
    
    private(set) var selectedMinute: Int?
    
    let hourItemView: RyPickerItemListView = {
        let temp = RyPickerItemListView(frame: CGRect.zero,
                                        widthContainer: RyListWidthContainer(.zero,
                                                                             [.flexible,.fixed(width: 40),.fixed(width: 75)],
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
    
    let symbolItem: RyPickerListData = {
        let widthContainer = RyListWidthContainer(.zero,
                                                  [.flexible, .fixed(width: 40)],
                                                  .zero)
        let titles = ["昨夜", "今天"]
        var items: [RyListItem] = []
        for (index,thisTitle) in titles.enumerated(){
            items.append(RyPickerRowData(index: index,
                                         title: thisTitle,
                                         obj: thisTitle,
                                         postion: .right(RyPickerViewItemWidth.fixed(width: 40)),
                                         cellType: RyRoundLabelTableViewCell.self))
        }
        let temp = RyPickerListData(dataSource: items, widthContainer: widthContainer)
        temp.pickerItemView.isUserInteractionEnabled = false
        temp.pickerItemView.tableView.tag = 99
        return temp
    }()
    
    var symbolItemView: RyPickerItemListView{
        return symbolItem.pickerItemView
    }
    
    lazy var totalItemWidths:[RyPickerViewItemWidth] = {
        var temp = hourItemView.widthContainer.widths
        temp.append(contentsOf: minuteItemView.widthContainer.widths)
        return temp
    }()
    
    var calendar: Calendar{
        return Calendar.current
    }
    
    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        super.init()
        selectedMinute = calendar.component(.minute, from: startDate)
        hourItemView.dataSouce = self
        hourItemView.delegate = self
        minuteItemView.dataSouce = self
        minuteItemView.delegate = self
    }
    
    func reload(andFixAtDate date: Date) {
        let minute = calendar.component(.minute, from: date)
        let num = hourItemView.tableView.numberOfRows(inSection: 0)
        var todoIndex: Int? = nil
        for index in 0..<num{
            let indexPath = IndexPath(row: index, section: 0)
            let item = hourItemView.dataSouce?.pickerItemListView(hourItemView, cellDataForRowAt: indexPath)
            if let thisDate = item?.objInPicker as? Date,
                calendar.compare(thisDate, to: date, toGranularity: .hour) == .orderedSame{
                todoIndex = index
                break
            }
        }
        hourItemView.reload(andFixAtIndex: todoIndex ?? 0, completion: nil)
        minuteItemView.reload(andFixAtTitle: String(format: "%02d", minute))
        adjustSymbolItemView()
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
        return zeroDate(with: startDate)
    }
    
    var zeroEndDate: Date{
        return zeroDate(with: endDate)
    }
    
    func zeroDate(with date: Date) -> Date{
        let hour = calendar.component(.hour, from: date)
        return calendar.date(bySettingHour: hour, minute: 0, second: 0, of: date)!
    }
    
    func numberOfRows(in itemListView: RyPickerItemListView) -> Int {
        if itemListView == hourItemView{
            let temp = calendar.dateComponents([.hour, .minute], from: zeroStartDate, to: zeroEndDate)
            var hour = temp.hour ?? 0
            if calendar.component(.minute, from: endDate) > 0{
                hour = hour + 1
            }
            return hour
        }
        guard let hourDate = hourItemView.selectedObj?.objInPicker as? Date else{
            return 12
        }
        var start = 0
        var end = 55
        if calendar.compare(hourDate, to: startDate, toGranularity: Calendar.Component.hour) == .orderedSame{
            start = calendar.component(Calendar.Component.minute, from: startDate)
        }
        
        if calendar.compare(hourDate, to: endDate, toGranularity: Calendar.Component.hour) == .orderedSame{
            end = calendar.component(Calendar.Component.minute, from: endDate)
        }
        let num = (end - start)/5 + 1
        return num
    }
    
    func pickerItemListView(_ pickerItemListView: RyPickerItemListView,
                            cellDataForRowAt indexPath: IndexPath) -> RyListItem{
        if pickerItemListView == hourItemView{
            let temp = calendar.date(byAdding: .hour,
                                             value: indexPath.row,
                                             to: startDate) ?? startDate
            let hour = calendar.component(Calendar.Component.hour, from: temp)
            let item = RyPickerRowData(index: indexPath.row, title: String(format: "%02d", hour))
            item.objInPicker = temp
            item.postion = .right(RyPickerViewItemWidth.fixed(width: 75))
            return item
        }
        guard let hourDate = hourItemView.selectedObj?.objInPicker as? Date else{
            return RyPickerRowData(index: 0, title: "-")
        }
        
        var markDate = zeroDate(with: hourDate)
        if calendar.compare(hourDate, to: startDate, toGranularity: Calendar.Component.hour) == .orderedSame{
            markDate = startDate
        }
        
        let temp = calendar.date(byAdding: .minute,
                                         value: indexPath.row * 5,
                                         to: markDate) ?? markDate
        let minute = calendar.component(.minute, from: temp)
        let item = RyPickerRowData(index: indexPath.row, title: String(format: "%02d", minute))
        item.objInPicker = temp
        item.postion = .left(RyPickerViewItemWidth.fixed(width: 75))
        return item
    }
}


extension RyDatePickerDataSource: RyPickerItemBaseViewDelegate{
    func itemBaseViewDidScroll(_ itemBaseView: RyPickerItemBaseView) {
        if itemBaseView != hourItemView{
            return
        }
        adjustSymbolItemView()
    }
    
    func adjustSymbolItemView(){
        guard let hourDate = hourItemView.currentObj?.objInPicker as? Date else{
            return
        }
        let inSameDayAs = Calendar.current.isDate(hourDate, inSameDayAs: endDate)
        if inSameDayAs, symbolItem.pickerItemView.selectedIndex != 1{
            symbolItem.pickerItemView.scroll(to: 1, animated: true)
        }
        
        if !inSameDayAs, symbolItem.pickerItemView.selectedIndex != 0{
            symbolItem.pickerItemView.scroll(to: 0, animated: true)
        }
    }
    
    func itemBaseViewWillBeginDragging(_ itemBaseView: RyPickerItemBaseView) {
        if itemBaseView != hourItemView{
            return
        }
        if let temp = minuteItemView.selectedObj?.objInPicker as? Date{
            selectedMinute = calendar.component(.minute, from: temp)
        }else{
            selectedMinute = nil
        }
    }
    
    func itemBaseView(_ itemBaseView: RyPickerItemBaseView, didSelectRow row: Int, preSelectedRow: RyPickerListable?) {
//        print("didSelectRow \(row)")
        if row == preSelectedRow?.rowForObjInPicker{
            return
        }
        
        func handleDelegate(){
            if let temp = minuteItemView.selectedObj?.objInPicker as? Date{
                delegate?.datePickerDataSource(self, didSelectedDateChanged: temp)
            }
        }
        
        if itemBaseView == minuteItemView{
            handleDelegate()
        }

        if itemBaseView == hourItemView{
            var title: String? = nil

            if let selectedMinute = selectedMinute{
                title = "\(selectedMinute)"
            }
            minuteItemView.reload(andFixAtTitle: title) {
                handleDelegate()
            }
        }

    }
}
