//
//  RyPickerItemBaseView.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/27.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

protocol RyPickerItemBaseViewDelegate: NSObjectProtocol {
    func itemBaseView(_ itemBaseView: RyPickerItemBaseView, didSelectRow row: Int, preSelectedRow: RyPickerListable?)
    func itemBaseViewWillBeginDragging(_ itemBaseView: RyPickerItemBaseView)
}

protocol RyPickerItemBaseViewLayoutDelegate: NSObjectProtocol {
    func itemBaseView(_ itemBaseView: RyPickerItemBaseView, widthForItemWidth itemWidth: RyPickerViewItemWidth) -> CGFloat
}


class RyPickerItemBaseView: UIView {
    
    weak var delegate: RyPickerItemBaseViewDelegate?
    
    weak var layoutDelegate: RyPickerItemBaseViewLayoutDelegate?
    
    var selectedIndex: Int{
        return 0
    }
    
    var currentIndex: Int{
        return 0
    }
    
    var selectedObj: RyListItem?{
        return nil
    }
    
    var currentObj: RyListItem?{
        return nil
    }
    
    func widthForItemWidth(_ itemWidth: [RyPickerViewItemWidth]) -> CGFloat{
        if let layoutDelegate = layoutDelegate{
            var length = CGFloat()
            for thisWidth in itemWidth{
                length = length + layoutDelegate.itemBaseView(self, widthForItemWidth: thisWidth)
            }
            return length
        }else{
            let itemBaseViewW = bounds.width
            var length = CGFloat()
            for thisWidth in itemWidth{
                length = length + thisWidth.width(in: itemBaseViewW, flexibleWidth: itemBaseViewW)
            }
            return length
        }
    }
    
    func reload(){
        
    }
    
    func reload(andFixAtTitle title: String?, completion:(()->Void)? = nil){
        
    }
    
    func scroll(to index: Int, animated: Bool, isSendAction: Bool = true){
        
    }
    
    func scroll(to title: String, animated: Bool, isSendAction: Bool = true){
    
    }
    
    func firstIndex(ofTitle title: String) -> Int?{
        return nil
    }
    
}
