//
//  KKCollectionFooterReusableView.swift
//  Swift_Demo
//
//  Created by sumian on 2018/12/17.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKCollectionFooterReusableView: UICollectionReusableView {
    
    static var identifier: String {
        return NSStringFromClass(KKCollectionFooterReusableView.self)
    }
    
    lazy var unitLabel:UILabel = {
        let temp = UILabel()
        temp.textColor = KCOLOR_TINT_COLOR
        temp.font = kFONT_15
        temp.textAlignment = .left
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPannel()
        addLayOut()
        initDatas()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPannel()  {
        backgroundColor = UIColor.white
        addSubview(unitLabel)
    }
    
    func initDatas()  {
        unitLabel.text = ":"
    }
    
    func addLayOut()  {
        unitLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
