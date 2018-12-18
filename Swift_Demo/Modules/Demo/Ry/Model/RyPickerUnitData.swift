//
//  RyPickerUnitData.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerUnitData: RyPickerViewBaseData{
    
    let itemWidth: RyPickerViewItemWidth
    
    override var type: RyPickerViewItemType{
        return .unit
    }
    
    let unit: String
    
    init(width: RyPickerViewItemWidth, unit: String) {
        self.itemWidth = width
        self.unit = unit
    }
    
    override func prepare(withCollection collectionView: UICollectionView) {
        collectionView.register(RyPickerLabelCollectionViewCell.self,
                                forCellWithReuseIdentifier: RyPickerLabelCollectionViewCell.defaultReuseIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RyPickerLabelCollectionViewCell.defaultReuseIdentifier,
                                                      for: indexPath) as! RyPickerLabelCollectionViewCell
        cell.label.text = unit
        return cell
    }
    
    override func preferredWidthForComponent(atBounds bounds: CGRect) -> RyPickerViewItemWidth {
        return itemWidth
    }
}
