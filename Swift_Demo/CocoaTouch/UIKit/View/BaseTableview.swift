//
//  BaseTableview.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/20.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit

class BaseTableview: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super .init(frame: frame, style: style)
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
