//
//  KKColumnPickerCell.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/27.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKColumnPickerCell: UITableViewCell {

    var isFocoused: Bool = false
    
    lazy var contentLabel: KKLabel = {
        let label = KKLabel()
        label.font = kFONT_18
        label.textColor = kCOLOR_TEXT_FIRST
        label.backgroundColor = kCOLOR_WHITE
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setPannel()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPannel() {
        addSubview(contentLabel)
    }
    
    func setConstraints()  {
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func updateDatas(text:String)  {
        contentLabel.text = text
        setStyle()
    }
    
    func setContentLableEdgeInset(aligment:NSTextAlignment,space:CGFloat = 0)  {
        if space != 0 {
            let contentWidth = space
            switch aligment {
            case .left:
                contentLabel.edgeInsets = UIEdgeInsets.init(top: 0, left: contentWidth, bottom: 0, right: 0)
            case .right:
                contentLabel.edgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: contentWidth)
            default:
                contentLabel.edgeInsets = UIEdgeInsets.init(top: 0, left: contentWidth/2, bottom: 0, right: contentWidth/2)
            }
        }
        else{
            if let content = contentLabel.text {
                let contentWidth = content.width(withConstraniedHeight: 167/3, font: kFONT_15)
                switch aligment {
                case .left:
                    contentLabel.edgeInsets = UIEdgeInsets.init(top: 0, left: contentWidth, bottom: 0, right: 0)
                case .right:
                    contentLabel.edgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: contentWidth)
                default:
                    contentLabel.edgeInsets = UIEdgeInsets.init(top: 0, left: contentWidth/2, bottom: 0, right: contentWidth/2)
                }
            }
        }
    }
    
    
    
    func setStyle()  {
        if isFocoused {
            contentLabel.textColor = KCOLOR_TINT_COLOR
        }
        else{
            contentLabel.textColor = kCOLOR_TEXT_FIRST
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
