//
//  RyPickerView.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/17.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit
import SnapKit

protocol RyPickerViewDelegate: NSObjectProtocol {
    func pickerView(didTapAction pickerView: RyPickerView)
}

class RyPickerView: UIView {
    
    //就是持有，不weak
    let dataSource: RyPickerViewDataSource
    
    //delegate 还是要weak
    weak var delegate: RyPickerViewDelegate?
    
    var preferredHeight: CGFloat = 55 + 55 + 187
    
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
    
    init(frame: CGRect = CGRect.zero, dataSource: RyPickerViewDataSource) {
        self.dataSource = dataSource
        super.init(frame: frame)
        setupSubview()
        addLayout()
    }
    
    func reload(){
        titleLabel.text = dataSource.titleOfPicker(in: self)
        let count = dataSource.numberOfComponents(in: self)
        for index in 0..<count {
            let itemView = dataSource.pickerView(self, itemViewForComponent: index)
            itemView.reload()
        }
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

    func reloadComponent(_ component: Int){
        let itemView = dataSource.pickerView(self, itemViewForComponent: component)
        itemView.reload()
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
    
    @objc func onActionButton(sender: Any){
        delegate?.pickerView(didTapAction: self)
    }
    
    func setupSubview(){
        backgroundColor = RyUI.color.B1
        titleLabel.text = dataSource.titleOfPicker(in: self)
        addSubview(contentView)
        addSubview(titleLabel)
        addSubview(actionButton)
        addSubview(topLayerView)
        let count = dataSource.numberOfComponents(in: self)
        for index in 0..<count{
            let itemView = dataSource.pickerView(self, itemViewForComponent: index)
            itemView.layoutDelegate = self
            contentView.addSubview(itemView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 55)
        actionButton.frame = CGRect(x: 0, y: bounds.height-55, width: bounds.width, height: 55)
        let contentViewH = bounds.height - titleLabel.bounds.height - 10 - actionButton.frame.height - 10
        contentView.frame = CGRect(x: 0, y: titleLabel.frame.maxY+10, width: bounds.width, height: contentViewH)
        
        let count = dataSource.numberOfComponents(in: self)
        var itemX: CGFloat = 0
        for index in 0..<count{
            let itemView = dataSource.pickerView(self, itemViewForComponent: index)
            let width = dataSource.pickerView(self, widthForComponent: index)
            itemView.frame = CGRect(x: itemX, y: 0, width: width, height: contentViewH)
            itemX = itemView.frame.maxX
        }
    }
    func addLayout(){
        
        actionButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(55)
        }
        
        topLayerView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(actionButton.snp.top).offset(-10)
        }
    }
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = RyUI.color.T1
        temp.font = UIFont.systemFont(ofSize: 16)
        temp.textAlignment = .center
        temp.backgroundColor = RyUI.color.B2
        return temp
    }()
    
    lazy var actionButton:UIButton = {
        let temp = UIButton()
        temp.setTitle("确定", for: .normal)
        temp.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        temp.setTitleColor(RyUI.color.T1, for: .normal)
        temp.backgroundColor = RyUI.color.B2
        temp.addTarget(self, action: #selector(onActionButton(sender:)), for: .touchUpInside)
        return temp
    }()
    
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
    
    lazy var bgView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(onBgViewTap(sender:)))
        tap.delegate = self
        temp.addGestureRecognizer(tap)
        return temp
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RyPickerView: RyPickerItemBaseViewLayoutDelegate{
    func itemBaseView(_ itemBaseView: RyPickerItemBaseView, widthForItemWidth itemWidth: RyPickerViewItemWidth) -> CGFloat{
        return dataSource.pickerView(self, widthForItemWidth: itemWidth)
    }
}
