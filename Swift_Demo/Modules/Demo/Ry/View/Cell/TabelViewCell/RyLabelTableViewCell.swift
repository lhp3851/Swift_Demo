//
//  RyLabelTableViewCell.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

protocol RyLabelCellDataProtocol: RyCellDataBaseProtocol{
    var ryltvc_title: String {get}
}

extension RyLabelCellDataProtocol{
    func cellType(userInfo: [String : Any]?) -> (UITableViewCell & RyCellProtocol).Type {
        return RyLabelTableViewCell.self
    }
}

class RyLabelTableViewCell: RyBaseTableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        addLayout()
        selectionStyle = .none
    }
    
    override func update(withData data: RyCellDataBaseProtocol) {
        super.update(withData: data)
        if let item = data as? RyLabelCellDataProtocol{
            label.text = item.ryltvc_title
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
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
    
    override class func cellHeightWithTableViewWidth(_ width: CGFloat, _ cellData: RyCellDataBaseProtocol?) -> CGFloat{
        return 55
    }
    
    lazy var label: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.textColor = RyUI.color.T2
        temp.font = UIFont.systemFont(ofSize: 18)
        temp.adjustsFontSizeToFitWidth = true
        return temp
    }()
}
