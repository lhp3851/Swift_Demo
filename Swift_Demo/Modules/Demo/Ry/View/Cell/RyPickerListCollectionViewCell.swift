//
//  RyPickerListCollectionViewCell.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyPickerListCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubview()
        addLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubview(){
        contentView.addSubview(tableView)
    }
    
    func addLayout(){
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        tableView.frame = self.frame
    }
    
    lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.showsVerticalScrollIndicator = false
        temp.showsHorizontalScrollIndicator = false
        temp.separatorStyle = .none
        temp.decelerationRate = UIScrollViewDecelerationRateFast
        return temp
    }()
}

