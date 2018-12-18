//
//  RyPickerView.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/17.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit
import SnapKit

class RyPickerView: UIView {
    
    //就是持有，不weak
    let dataSource: RyPickerViewDataSource
    
    var preferredHeight: CGFloat = 55 + 55 + 187
    
    init(frame: CGRect = CGRect.zero, dataSource: RyPickerViewDataSource) {
        self.dataSource = dataSource
        super.init(frame: frame)
        setupSubview()
        addLayout()
        prepare()
    }
    
    func prepare(){
        let count = dataSource.numberOfComponents(in: self)
        for index in 0..<count {
            let model = dataSource.pickerView(self, modelForComponent: index)
            model.prepare(withCollection: collectionView)
        }
    }
    
    func reload(){
        titleLabel.text = dataSource.titleOfPicker(in: self)
        collectionView.reloadData()
    }
    
    @objc func onActionButton(sender: Any){
        
    }
    
    func setupSubview(){
        backgroundColor = RyUI.color.B1
        addSubview(collectionView)
        addSubview(titleLabel)
        addSubview(actionButton)
        addSubview(topLayerView)
    
    }
    
    func addLayout(){
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(55)
        }
        
        actionButton.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(55)
        }
        
        topLayerView.snp.makeConstraints { (make) in
            make.edges.equalTo(collectionView)
        }
        
        collectionView.snp.makeConstraints { (make) in
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
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()//这个系统layout可能满足不了
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let temp = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        temp.backgroundColor = UIColor.white
        temp.delegate = self
        temp.dataSource = self
        return temp
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension RyPickerView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let count = dataSource.numberOfComponents(in: self)
        return count > 0 ? 1 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfComponents(in: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataSource.pickerView(self, modelForComponent: indexPath.row)
        let cell = model.collectionView(collectionView, cellForItemAt: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = dataSource.pickerView(self, widthForComponent: indexPath.row)
        return CGSize(width: w, height: collectionView.bounds.height)
    }

}
