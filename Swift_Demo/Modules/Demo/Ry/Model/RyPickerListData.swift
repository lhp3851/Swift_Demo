//
//  RyPickerListData.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerListData:RyPickerViewBaseData, RyPickerItemListViewDataSource{

    typealias ListItem = RyPickerListable & RyCellDataBaseProtocol
    
    var dataSource: [RyListItem]
    
    override var type: RyPickerViewItemType{
        return .list
    }
    
    var pickerItemView: RyPickerItemListView
    
    var header: String?{
        get{
            return pickerItemView.headerLabel.text
        }
        set{
            pickerItemView.headerLabel.text = newValue
        }
    }
    
    var footer: String?{
        get{
            return pickerItemView.footerLabel.text
        }
        set{
            pickerItemView.footerLabel.text = newValue
        }
    }

    init(dataSource: [RyListItem],
         widthContainer: RyListWidthContainer,
         inset: RyPickerInset = .zero) {
        self.dataSource = dataSource
        self.pickerItemView = RyPickerItemListView(frame: CGRect.zero,
                                                   widthContainer: widthContainer,
                                                   inset: inset)
        super.init()
        self.pickerItemView.dataSouce = self
    }
    
    override func preferredWidthForComponent() -> [RyPickerViewItemWidth]{
        var temp = pickerItemView.widthContainer.widths
        temp.append(pickerItemView.inset.left)
        temp.append(pickerItemView.inset.right)
        return temp
    }
    
    override func pickerItemView(at bounds: CGRect) -> RyPickerItemBaseView {
        return pickerItemView
    }
    
    func numberOfRows(in itemListView: RyPickerItemListView) -> Int{
        return dataSource.count
    }
    
    func pickerItemListView(_ pickerItemListView: RyPickerItemListView,
                            cellDataForRowAt indexPath: IndexPath) -> ListItem{
        return dataSource[indexPath.row]
    }
}
