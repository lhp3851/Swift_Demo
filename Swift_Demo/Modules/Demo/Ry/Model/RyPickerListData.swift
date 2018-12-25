//
//  RyPickerListData.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerListData:RyPickerViewBaseData, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{

    typealias ListItem = RyPickerListable & RyCellDataBaseProtocol
    
    var dataSource: [ListItem]
    
    let itemWidth: RyPickerViewItemWidth
    
    let defaultIndex: Int
    
    override var type: RyPickerViewItemType{
        return .list
    }

    init(dataSource: [ListItem], width: RyPickerViewItemWidth, defaultIndex: Int) {
        self.itemWidth = width
        self.dataSource = dataSource
        self.defaultIndex = defaultIndex
    }
    
    
    override func prepare(withCollection collectionView: UICollectionView) {
        collectionView.register(RyPickerListCollectionViewCell.self,
                                forCellWithReuseIdentifier: RyPickerListCollectionViewCell.defaultReuseIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RyPickerListCollectionViewCell.defaultReuseIdentifier,
                                                      for: indexPath) as! RyPickerListCollectionViewCell
        cell.tableView.dataSource = self
        cell.tableView.delegate = self
        return cell
    }
    
    override func preferredWidthForComponent(atBounds bounds: CGRect) -> RyPickerViewItemWidth{
        return itemWidth
    }
    
    override func reload(in pickerView: RyPickerView, inComponent component: Int){
//        let indexpath = IndexPath.init(row: component, section: 0)
//        let cell:RyPickerListCollectionViewCell = pickerView.collectionView.cellForItem(at: indexpath) as! RyPickerListCollectionViewCell
//        cell.tableView.reloadData()
    }
    
    override func selectedItem(in pickerView: RyPickerView, inComponent component: Int) -> RyPickerListable?{
        return dataSource[component]
    }
    
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = dataSource[indexPath.row]
        return item.cellType(userInfo: nil).cellHeightWithTableViewWidth(tableView.bounds.width, item)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollEnded(scrollView: scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollEnded(scrollView: scrollView)
    }
    
    //滚动结束
    func scrollEnded(scrollView:UIScrollView)  {
        let tableView = scrollView as! UITableView
        let item = dataSource[defaultIndex]
        let cellHeight = item.cellType(userInfo: nil).cellHeightWithTableViewWidth(tableView.bounds.width, item)
        let lineNumber = Int(round(scrollView.contentOffset.y / cellHeight)) + 1
        scrollToIndex(index: lineNumber , tableView: tableView, animated: true)
    }
    
    //选中的颜色修改
    func setSelectedItem(index:Int,tableView:UITableView)  {
        let indexPath = IndexPath.init(row: index, section: 0)
        for cell in tableView.visibleCells {
            let temp = cell as! RyLabelTableViewCell
            temp.setSelected(false, animated: false)
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? RyLabelTableViewCell {
             cell.setSelected(true, animated: true)
        }
    }
    
    //默认选中
    func scrollToDefaultItem(tableView:UITableView)  {
        scrollToIndex(index: defaultIndex, tableView: tableView, animated: false)
    }
    
    //滚到指定index
    func scrollToIndex(index:Int,tableView:UITableView,animated:Bool = false) {
        let indexPath = IndexPath.init(row: index, section: 0)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.36) {
            self.setSelectedItem(index: index, tableView: tableView)
            self.pickeDatas(index: index)
        }
    }
    
    //（最后再处理选中事件的抛出，用与处理联动）
    func pickeDatas(index:Int)  {
        itemScrollDelegate?.item(self, didSelectRow: index)
    }
}
