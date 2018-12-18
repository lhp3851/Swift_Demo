//
//  RyPickerHolderData.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerHolderData: RyPickerViewItem{
    
    let itemWidth: RyPickerViewItemWidth
    
    let type: RyPickerViewItemType = .holder
    
    init(width: RyPickerViewItemWidth) {
        self.itemWidth = width
    }
    
    func prepare(withCollection collectionView: UICollectionView) {
        collectionView.register(RyPickerHolderCollectionViewCell.self,
                                forCellWithReuseIdentifier: RyPickerHolderCollectionViewCell.defaultReuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RyPickerHolderCollectionViewCell.defaultReuseIdentifier,
                                                      for: indexPath)
        return cell
    }
    
    func preferredWidthForComponent(atBounds bounds: CGRect) -> RyPickerViewItemWidth {
        return itemWidth
    }
    
    func reload() {
        
    }
}
