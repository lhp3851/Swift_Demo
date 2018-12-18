//
//  RyPickerListData.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerListData:NSObject, RyPickerViewItem, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    
    var dataSource: [RyCellDataBaseProtocol]
    
    let width: CGFloat
    
    let defaultIndex: Int
    
    init(dataSource: [RyCellDataBaseProtocol], width: CGFloat, defaultIndex: Int) {
        self.width = width
        self.dataSource = dataSource
        self.defaultIndex = defaultIndex
    }
    
    let type: RyPickerViewItemType = .list
    
    func prepare(withCollection collectionView: UICollectionView) {
        collectionView.register(RyPickerListCollectionViewCell.self,
                                forCellWithReuseIdentifier: RyPickerListCollectionViewCell.defaultReuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RyPickerListCollectionViewCell.defaultReuseIdentifier,
                                                      for: indexPath) as! RyPickerListCollectionViewCell
        cell.tableView.dataSource = self
        cell.tableView.delegate = self
        return cell
    }
    
    func preferredWidthForComponent(atBounds bounds: CGRect) -> CGFloat{
        return width
    }
    
    func reload(){
        //
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
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    //处理选中的颜色修改，
    //处理默认选中，
    //处理滚到指定index
    //（最后再处理选中事件的抛出，用与处理联动）
}
