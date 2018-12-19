//
//  RyPickerHolderData.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerHolderData: RyPickerViewBaseData{
    
    override var type: RyPickerViewItemType{
        return .holder
    }
    
    let itemWidth: RyPickerViewItemWidth
    
    init(width: RyPickerViewItemWidth) {
        self.itemWidth = width
    }
    
    override func prepare(withCollection collectionView: UICollectionView) {
        collectionView.register(RyPickerHolderCollectionViewCell.self,
                                forCellWithReuseIdentifier: RyPickerHolderCollectionViewCell.defaultReuseIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RyPickerHolderCollectionViewCell.defaultReuseIdentifier,
                                                      for: indexPath)
        cell.backgroundColor = RyUI.color.B1
        return cell
    }
    
    override func preferredWidthForComponent(atBounds bounds: CGRect) -> RyPickerViewItemWidth {
        return itemWidth
    }
}
