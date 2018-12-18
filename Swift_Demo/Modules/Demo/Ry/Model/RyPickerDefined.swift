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

protocol RyPickerViewItem {
    var type: RyPickerViewItemType {get}
    
    func prepare(withCollection collectionView: UICollectionView)
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func preferredWidthForComponent(atBounds bounds: CGRect) -> CGFloat
    
    func reload()
}
