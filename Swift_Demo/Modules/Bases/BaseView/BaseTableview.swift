//
//  BaseTableview.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/20.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit

class BaseTableview: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super .init(frame: frame, style: style)
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
