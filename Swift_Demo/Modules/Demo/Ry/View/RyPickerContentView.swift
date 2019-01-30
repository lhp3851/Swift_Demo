//
//  RyPickerContentView.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/2.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import UIKit

protocol RyPickerContentViewDataSource {
    func numberOfComponents(in pickerView: RyPickerContentView) -> Int
    func pickerView(_ pickerView: RyPickerContentView, widthForComponent component: Int) -> CGFloat
    func pickerView(_ pickerView: RyPickerContentView, itemViewForComponent component: Int) -> RyPickerItemBaseView
    func titleOfPicker(in pickerView: RyPickerContentView) -> String?
    func pickerView(_ pickerView: RyPickerContentView, widthForItemWidth itemWidth: RyPickerViewItemWidth) -> CGFloat
}


class RyPickerContentView: UIView, RyPickerItemBaseViewLayoutDelegate {
    //就是持有，不weak
    let dataSource: RyPickerContentViewDataSource
    
    var selectedIndexes: [Int] = []
    
    var selectedObjs: [RyPickerListable]{
        var temp = [RyPickerListable]()
        let count = dataSource.numberOfComponents(in: self)
        for index in 0..<count {
            let itemView = dataSource.pickerView(self, itemViewForComponent: index)
            if let obj = itemView.currentObj{
                temp.append(obj)
            }
        }
        return temp
    }
    
    init(frame: CGRect = CGRect.zero, dataSource: RyPickerContentViewDataSource) {
        self.dataSource = dataSource
        super.init(frame: frame)
        setupSubview()
        addLayout()
    }
    
    func reload(){
        let count = dataSource.numberOfComponents(in: self)
        for index in 0..<count {
            reloadComponent(index)
        }
    }
    
    func reloadComponent(_ component: Int){
        let itemView = dataSource.pickerView(self, itemViewForComponent: component)
        itemView.reload()
    }
    
    func selectedObj(inComponent component: Int) -> RyPickerListable?{
        let item = dataSource.pickerView(self, itemViewForComponent: component)
        return item.selectedObj
    }
    
    func selected(titles: [String]){
        for (index, thisTitle) in titles.enumerated() {
            if index >= dataSource.numberOfComponents(in: self){
                break
            }
            let itemView = dataSource.pickerView(self, itemViewForComponent: index)
            itemView.scroll(to: thisTitle, animated: false, isSendAction: false)
        }
    }
    
    func selected(indexs: [Int]){
        for (index, thisIndex) in indexs.enumerated() {
            if index >= dataSource.numberOfComponents(in: self){
                break
            }
            let itemView = dataSource.pickerView(self, itemViewForComponent: index)
            itemView.scroll(to: thisIndex, animated: false, isSendAction: false)
        }
    }
    
    func selectedRow(inComponent component: Int) -> Int{
        let itemView = dataSource.pickerView(self, itemViewForComponent: component)
        return itemView.selectedIndex
    }
    
    func selectRow(_ row: Int, inComponent component: Int, animated: Bool){
        let itemView = dataSource.pickerView(self, itemViewForComponent: component)
        itemView.scroll(to: row, animated: animated)
    }
    
    func itemView(forComponent component: Int) -> RyPickerItemBaseView{
        return dataSource.pickerView(self, itemViewForComponent: component)
    }
    
    func setupSubview(){
        addSubview(contentView)
        addSubview(topLayerView)
        let count = dataSource.numberOfComponents(in: self)
        for index in 0..<count{
            let itemView = dataSource.pickerView(self, itemViewForComponent: index)
            itemView.layoutDelegate = self
            contentView.addSubview(itemView)
        }
        topLayerView.addSubview(unitLabel)
    }
    
    func addLayout(){
        unitLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(topLayerView.snp.centerX).offset(17.5)
            make.width.equalTo(35)
        }
    }
    
    func frameOfContentView(in bounds: CGRect) -> CGRect{
        return bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = frameOfContentView(in: bounds)
        let count = dataSource.numberOfComponents(in: self)
        let contentViewH = contentView.frame.size.height
        var itemX: CGFloat = 0
        for index in 0..<count{
            let itemView = dataSource.pickerView(self, itemViewForComponent: index)
            let width = dataSource.pickerView(self, widthForComponent: index)
            itemView.frame = CGRect(x: itemX, y: 0, width: width, height: contentViewH)
            itemX = itemView.frame.maxX
        }
        topLayerView.frame = contentView.frame
    }
    
    lazy var topLayerView: TopLayerView = {
        let temp = TopLayerView()
        temp.isUserInteractionEnabled = false
        return temp
    }()
    
    lazy var contentView:UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.white
        return temp
    }()
    
    lazy var unitLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont.systemFont(ofSize: 18)
        temp.textAlignment = .center
        temp.textColor = RyUI.color.B3
        return temp
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func itemBaseView(_ itemBaseView: RyPickerItemBaseView, widthForItemWidth itemWidth: RyPickerViewItemWidth) -> CGFloat{
        return dataSource.pickerView(self, widthForItemWidth: itemWidth)
    }
}
