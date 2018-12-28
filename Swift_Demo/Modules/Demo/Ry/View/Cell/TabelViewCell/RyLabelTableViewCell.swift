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
    var ryltvc_position: RyLabelTableViewCell.Position {get}
}

extension RyLabelCellDataProtocol{
    func cellType(userInfo: [String : Any]?) -> (UITableViewCell & RyCellProtocol).Type {
        return RyLabelTableViewCell.self
    }
}

class RyLabelTableViewCell: RyBaseTableViewCell {
    enum Position: Equatable {
        case expand
        case left(RyPickerViewItemWidth)
        case right(RyPickerViewItemWidth)
        static func == (lhs: RyLabelTableViewCell.Position, rhs: RyLabelTableViewCell.Position) -> Bool {
            switch lhs {
            case .expand:
                if case .expand = rhs{
                    return true
                }
                return false
            case .left(let lWidth):
                if case let .left(rWidth) = rhs, rWidth == lWidth{
                    return true
                }
                return false
            case .right(let lWidth):
                if case let .right(rWidth) = rhs, rWidth == lWidth{
                    return true
                }
                return false
            }
        }
    }
    
    var position: Position = .expand{
        didSet{
            if oldValue != position{
                setNeedsLayout()
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
        selectionStyle = .none
    }
    
    override func update(withData data: RyCellDataBaseProtocol) {
        super.update(withData: data)
        if let item = data as? RyLabelCellDataProtocol{
            label.text = item.ryltvc_title
            position = item.ryltvc_position
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            label.textColor = RyUI.color.B3
        }else{
            label.textColor = RyUI.color.T2
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubview(){
        contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = contentView.bounds.width
        let h = contentView.bounds.height
        switch position {
        case .expand:
            label.frame = contentView.bounds
        case .left(let widthItem):
            let labelWidth = widthItem.width(in: w, flexibleWidth: w)
            label.frame = CGRect(x: 0, y: 0, width: labelWidth, height: h)
        case .right(let widthItem):
            let labelWidth = widthItem.width(in: w, flexibleWidth: w)
            label.frame = CGRect(x: w-labelWidth, y: 0, width: labelWidth, height: h)
        }
    }
    
    override class func cellHeightWithTableViewWidth(_ width: CGFloat, _ cellData: RyCellDataBaseProtocol?) -> CGFloat{
        return 167/3
    }
    
    lazy var label: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.textColor = RyUI.color.T1
        temp.font = UIFont.systemFont(ofSize: 18)
        temp.adjustsFontSizeToFitWidth = true
        return temp
    }()
}
