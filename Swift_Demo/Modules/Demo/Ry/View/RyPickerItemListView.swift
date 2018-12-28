//
//  RyPickerItemListView.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/27.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

protocol RyPickerItemListViewDataSource: NSObjectProtocol {
    func numberOfRows(in itemListView: RyPickerItemListView) -> Int
    func pickerItemListView(_ pickerItemListView: RyPickerItemListView,
                            cellDataForRowAt indexPath: IndexPath) -> RyListItem
    
}

class RyPickerItemListView: RyPickerItemBaseView {
    
    let widthContainer: RyListWidthContainer
    
    let inset: RyPickerInset
    
    weak var dataSouce: RyPickerItemListViewDataSource?
    
    private(set) var isInit = false
    
    private var currentIndex: Int{
        if tableView.bounds.height <= 1{
            return _endSelectedIndex
        }
        let cellHeight = tableView.bounds.height / 3.0
        let temp = Int(round(tableView.contentOffset.y / cellHeight)) + 1
        return validIndex(of: temp)
    }
    
    private var _endSelectedIndex: Int = 0
    
    override var selectedIndex: Int{
        return currentIndex
    }
    
    override var selectedObj: RyListItem?{
        return dataSouce?.pickerItemListView(self, cellDataForRowAt: IndexPath(row: currentIndex, section: 0))
    }
    
    init(frame: CGRect, widthContainer: RyListWidthContainer, inset: RyPickerInset) {
        self.widthContainer = widthContainer
        self.inset = inset
        super.init(frame: frame)
        _endSelectedIndex = selectedIndex
        setupSubview()
    }
    
    override func scroll(to index: Int, animated: Bool, isSendAction: Bool = true){
        let todoIndex = validIndex(of: index)
        if !isInit {
            _endSelectedIndex = todoIndex
        }
        let indexPath = IndexPath.init(row: todoIndex, section: 0)
        UIView.animate(withDuration: animated ? 0.3 : 0 , animations: {
            self.scrollToRow(at: indexPath, animated: animated, isSendAction: isSendAction)
        }) { (_) in
            self.setSelectedItem(index: todoIndex)
            self.pickeDatas(index: todoIndex)
        }
    }
    
    override func reload() {
        tableView.reloadData()
    }
    
    override func scroll(to title: String, animated: Bool, isSendAction: Bool = true){
        if let index = firstIndex(ofTitle: title){
            scroll(to: index, animated: animated,isSendAction: isSendAction)
        }
    }
    
    override func firstIndex(ofTitle title: String) -> Int?{
        guard let dataSouce = dataSouce else {
            return nil
        }
        let count = dataSouce.numberOfRows(in: self)
        var todoIndex: Int? = nil
        for index in 0..<count{
            let item = dataSouce.pickerItemListView(self, cellDataForRowAt: IndexPath(row: index, section: 0))
            if item.titleInPicker == title{
                todoIndex = index
                break
            }
        }
        return todoIndex
    }
    
    func validIndex(of index: Int) -> Int{
        guard let dataSource = dataSouce else {
            return 0
        }
        let lastIndex = max(0, (dataSource.numberOfRows(in: self) - 1))
        return min(lastIndex, max(0, index))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func scrollToRow(at indexPath: IndexPath, animated: Bool, isSendAction: Bool){
        if isSendAction{
            tableView.scrollToRow(at: indexPath, at: .middle, animated: animated)
        }else{
            let offSetY = CGFloat(indexPath.row-1) * (self.tableView.bounds.height / 3.0)
            self.tableView.setContentOffset(CGPoint(x: 0, y: offSetY),
                                            animated: animated)
        }
    }
    
    func setupSubview(){
        addSubview(headerLabel)
        addSubview(tableView)
        addSubview(footerLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let x = widthForItemWidth([inset.left])
        let h = bounds.height
        let headerWidth = widthForItemWidth([widthContainer.header])
        headerLabel.frame = CGRect(x: x, y: 0, width: headerWidth, height: h)
        let tableWidth = widthForItemWidth(widthContainer.content)
        if tableView.frame.height != h, h > 0.1{
            tableView.contentInset = UIEdgeInsetsMake(h / 3.0, 0, h / 3.0, 0)
        }
        tableView.frame = CGRect(x: headerLabel.frame.maxX, y: 0, width: tableWidth, height: h)
        let footerWidth = widthForItemWidth([widthContainer.footer])
        footerLabel.frame = CGRect(x: tableView.frame.maxX, y: 0, width: footerWidth, height: h)
        if h < 0.1 || isInit{
            return
        }
        isInit = true
        if _endSelectedIndex == 0{
            return
        }
        UIView.animate(withDuration: 0.01, animations: {
            self.tableView.reloadData()
        }) { (_) in
            self.scrollToRow(at: IndexPath(row: self._endSelectedIndex, section: 0),
                             animated: false,
                             isSendAction: false)
        }
    }
    
    lazy var headerLabel: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.textColor = RyUI.color.B3
        temp.font = UIFont.systemFont(ofSize: 18)
        temp.adjustsFontSizeToFitWidth = true
        temp.backgroundColor = UIColor.yellow
        return temp
    }()
    
    lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.showsVerticalScrollIndicator = false
        temp.showsHorizontalScrollIndicator = false
        temp.separatorStyle = .none
        temp.estimatedRowHeight = 0
//        temp.decelerationRate = UIScrollViewDecelerationRateFast
        temp.dataSource = self
        temp.delegate = self
        return temp
    }()
    
    lazy var footerLabel: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.textColor = RyUI.color.B3
        temp.font = UIFont.systemFont(ofSize: 18)
        temp.adjustsFontSizeToFitWidth = true
        temp.backgroundColor = UIColor.red
        return temp
    }()

}

extension RyPickerItemListView: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSouce?.numberOfRows(in: self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSouce!.pickerItemListView(self, cellDataForRowAt: indexPath)
        let cellType = item.cellType(userInfo: nil)
        let cell: UITableViewCell
        if let temp = tableView.dequeueReusableCell(withIdentifier: cellType.defaultReuseIdentifier){
            cell = temp
        }else{
            cell = cellType.init(style: UITableViewCellStyle.default, reuseIdentifier: cellType.defaultReuseIdentifier)
        }
        if let temp = cell as? RyBaseTableViewCell{
            temp.update(withData: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.setSelected(indexPath.row == _endSelectedIndex, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / 3.0
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollEnded()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollEnded()
    }
    
    //滚动结束
    func scrollEnded()  {
        let index = currentIndex
        _endSelectedIndex = index
        let indexPath = IndexPath.init(row: index, section: 0)
        let cellHeight = (tableView.bounds.height/3.0)
        let duration = (abs(tableView.contentOffset.y - CGFloat(index) * cellHeight) / cellHeight) * 0.3
        print("scrollEnded: \(indexPath.row)")
        UIView.animate(withDuration: TimeInterval(duration), animations: {
            self.tableView.scrollToRow(at: indexPath, at: .middle, animated: false)
        }) { (_) in
            self.setSelectedItem(index: index)
            self.pickeDatas(index: index)
        }
    }
    
    //选中的颜色修改
    func setSelectedItem(index:Int)  {
        let indexPath = IndexPath.init(row: index, section: 0)
        
        for cell in tableView.visibleCells {
            cell.setSelected(false, animated: false)
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.setSelected(true, animated: true)
        }
    }
    
    //（最后再处理选中事件的抛出，用与处理联动）
    func pickeDatas(index:Int)  {
        
    }
}


struct RyListWidthContainer {
    var header: RyPickerViewItemWidth
    var content: [RyPickerViewItemWidth]
    var footer: RyPickerViewItemWidth
    var widths: [RyPickerViewItemWidth]{
        var temp = content
        temp.append(header)
        temp.append(footer)
        return temp
    }
    
    init(_ header:RyPickerViewItemWidth,_ content: [RyPickerViewItemWidth],_ footer: RyPickerViewItemWidth) {
        self.header = header
        self.content = content
        self.footer = footer
    }
    
    init(_ header:RyPickerViewItemWidth,_ content: RyPickerViewItemWidth,_ footer: RyPickerViewItemWidth) {
        self.init(header, [content], footer)
    }
}
