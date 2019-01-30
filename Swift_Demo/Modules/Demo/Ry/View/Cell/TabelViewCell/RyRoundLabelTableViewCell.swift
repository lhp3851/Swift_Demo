//
//  RyRoundLabelTableViewCell.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2019/1/11.
//  Copyright © 2019年 Jerry. All rights reserved.
//

import UIKit

protocol RyRoundLabelCellDataProtocol: RyLabelCellDataProtocol{
    
}

extension RyRoundLabelCellDataProtocol{
    func cellType(userInfo: [String : Any]?) -> (UITableViewCell & RyCellProtocol).Type {
        return RyRoundLabelTableViewCell.self
    }
}

class RyRoundLabelTableViewCell: RyLabelTableViewCell {
    
    override func update(withData data: RyCellDataBaseProtocol) {
        super.update(withData: data)
        updateLabelBgViewFrame()
    }
    
    override func setupSubview() {
        super.setupSubview()
        contentView.insertSubview(labelBgView, belowSubview: label)
        label.textColor = RyUI.color.T2
        label.font = UIFont.systemFont(ofSize: 13)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.label.textColor = selected ? RyUI.color.B3 : RyUI.color.T1
        self.labelBgView.layer.borderColor = selected ? RyUI.color.B5.cgColor : RyUI.color.T2.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLabelBgViewFrame()
    }
    
    func updateLabelBgViewFrame(){
        var textSize = label.sizeThatFits(label.frame.size)
        textSize = CGSize(width: textSize.width + 8, height: textSize.height + 4)
        labelBgView.center = label.center
        labelBgView.frame.size = textSize
    }
    
    lazy var labelBgView: UIView = {
        let temp = UIView()
        temp.layer.cornerRadius = 4
        temp.layer.borderWidth = 1
        temp.layer.borderColor = RyUI.color.L1.cgColor
        temp.backgroundColor = RyUI.color.B2
        return temp
    }()
}
