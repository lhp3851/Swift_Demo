//
//  RyPickerDefined.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

protocol RyPickerViewDataSource {
    func numberOfComponents(in pickerView: RyPickerView) -> Int
    func pickerView(_ pickerView: RyPickerView, widthForComponent component: Int) -> CGFloat
    func pickerView(_ pickerView: RyPickerView, modelForComponent component: Int) -> RyPickerViewItem
    func titleOfPicker(in pickerView: RyPickerView) -> String?
}

enum RyPickerViewItemType {
    case holder
    case unit
    case list
}

enum RyPickerViewItemWidth{
    //比例 （factor： 0 ～ 1）
    case scale(factor: CGFloat)
    //固定宽度
    case fixed(width: CGFloat)
    //平均分配剩余的
    case flexible
    
    func width(in length: CGFloat) -> CGFloat?{
        switch self {
        case .fixed(let width):
            return width
        case .scale(let factor):
            return factor * length
        case .flexible:
            return nil
        }
    }
}

protocol RyPickerViewItem {
    var type: RyPickerViewItemType {get}
    
    func prepare(withCollection collectionView: UICollectionView)
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func preferredWidthForComponent(atBounds bounds: CGRect) -> RyPickerViewItemWidth
    
    func reload(in pickerView: RyPickerView, inComponent component: Int)
    
    func selectedItem(in pickerView: RyPickerView, inComponent component: Int) -> RyPickerListable?
}


protocol RyPickerListable {
    var objInPicker: Any {get}
    var rowForObjInPicker: Int {get}
    var titleInPicker: String {get}
}
