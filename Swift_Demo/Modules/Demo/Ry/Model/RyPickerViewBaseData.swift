//
//  RyPickerViewBaseData.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerViewBaseData: NSObject {
    
    var type: RyPickerViewItemType{
        return .holder
    }
    
    weak var itemScrollDelegate: RyPickerViewItemScrollDelegate?
    
    func prepare(withCollection collectionView: UICollectionView){
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: UICollectionViewCell.defaultReuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.defaultReuseIdentifier,
                                                      for: indexPath)
        return cell
    }
    
    func preferredWidthForComponent(atBounds bounds: CGRect) -> RyPickerViewItemWidth{
        return .flexible
    }
    
    func reload(in pickerView: RyPickerView, inComponent component: Int){
        
    }
    
    func selectedItem(in pickerView: RyPickerView, inComponent component: Int) -> RyPickerListable?{
        
        return nil
        
    }
    
}
