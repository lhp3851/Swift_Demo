//
//  RyPickerView + TopLayerView.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/17.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

extension RyPickerView{
    class TopLayerView: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupSubview()
            addLayout()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupSubview(){
            addSubview(topView)
            addSubview(topLineView)
            addSubview(bottomView)
            addSubview(bottomLineView)
        }
        
        func addLayout(){
            topView.snp.makeConstraints { (make) in
                make.left.top.right.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(1.0/3.0)
            }
            
            topLineView.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(topView.snp.bottom)
                make.height.equalTo(1)
            }
            
            bottomView.snp.makeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(1.0/3.0)
            }
            
            bottomLineView.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.bottom.equalTo(bottomView.snp.top)
                make.height.equalTo(1)
            }
        }
        
        lazy var topView: UIView = {
            let temp = UIView()
            temp.backgroundColor = UIColor.white.withAlphaComponent(0.7)
            return temp
        }()
        
        lazy var topLineView: UIView = {
            let temp = UIView()
            temp.backgroundColor = lineColor
            return temp
        }()
        
        lazy var bottomView: UIView = {
            let temp = UIView()
            temp.backgroundColor = UIColor.white.withAlphaComponent(0.7)
            return temp
        }()
        
        lazy var bottomLineView: UIView = {
            let temp = UIView()
            temp.backgroundColor = lineColor
            return temp
        }()
        
        let lineColor: UIColor = {
            let rgbValue: Int = 0xedeff0
            return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                           green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                           blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                           alpha: 1.0)
        }()
    }
}
