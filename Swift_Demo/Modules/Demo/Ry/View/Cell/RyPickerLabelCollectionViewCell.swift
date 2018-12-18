//
//  RyPickerLabelCollectionViewCell.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerLabelCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
        addLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubview(){
        contentView.addSubview(label)
    }
    
    func addLayout(){
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    lazy var label: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.textColor = RyUI.color.B3
        temp.font = UIFont.systemFont(ofSize: 18)
        return temp
    }()
}
