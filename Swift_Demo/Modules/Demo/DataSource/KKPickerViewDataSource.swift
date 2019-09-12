//
//  KKPickerViewDataSource.swift
//  Swift_Demo
//
//  Created by sumian on 2018/12/17.
//  Copyright © 2018 Jerry. All rights reserved.
//

import Foundation
import UIKit

protocol KKPickerViewDataSource {
    //列数
    var collumns:Int {get set}
    //选择器标题
    var title:String {get set}
    //单位
    var uinits:String {get set}
    //默认选中的数据索引
    var defaultIndex:[Int] {get set}
    //选择器子列表size
    var cellSize:CGSize {get set}
    //选择器数据源
    var datas:[Any] {get set}
}

//protocol KKPickerDataSourceProtocol: UITableViewDataSource {
//    // type
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell//
//    // selected index
//    // scroll to index
//}
//
//class KKPickerArrayDataSource:NSObject, KKPickerDataSourceProtocol {
//    var objs: [Any] = []
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return objs.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
//        return cell
//    }
//}
//
