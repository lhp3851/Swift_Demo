//
//  ContactsTableViewCell.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/15.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import Contacts

class ContactsTableViewCell: UITableViewCell {

    lazy var avatarImageView:UIImageView = {
        let view = UIImageView.init(frame: CGRect.zero)
        
        return view
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = kFONT_15
        label.textColor = kCOLOR_TEXT_FIRST
        return label
    }()
    
    lazy var phoneButton:UIButton = {
        let button = UIButton.init(frame: CGRect.zero)
        button.setTitleColor(kCOLOR_BUTTON_HEIGHT, for: .normal)
        button.titleLabel?.font = kFONT_13
        return button
    }()
    
    lazy var handlerButton:UIButton = {
        let button = UIButton.init(frame: CGRect.zero)
        button.setTitle("邀请", for: .normal)
        button.titleLabel?.font = kFONT_14
        button.setTitleColor(kCOLOR_WHITE, for: .normal)
        button.backgroundColor = kCOLOR_BUTTON_NORMOL
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 3.0
        button.addTarget(self, action: #selector(invite), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initPannel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initPannel() -> Void {
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.phoneButton)
        self.contentView.addSubview(self.handlerButton)
        setConstraint()
    }
    
    func setConstraint() -> Void {
        self.avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(kMARGIN_HORIZONE)
            make.top.equalTo(kFIT_INSTANCE.fitHeight(height: 5.0))
            make.bottom.equalTo(kFIT_INSTANCE.fitHeight(height: -5.0))
        }
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(kFIT_INSTANCE.fitWidth(width: 5.0))
            make.top.equalTo(self.avatarImageView)
        }
        self.phoneButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(kFIT_INSTANCE.fitHeight(height: 2.5))
            make.left.equalTo(self.nameLabel)
            make.bottom.equalTo(kFIT_INSTANCE.fitHeight(height: -5.0))
        }
        self.handlerButton.snp.makeConstraints { (make) in
            make.top.equalTo(kFIT_INSTANCE.fitHeight(height: 15.0))
            make.right.equalTo(-kMARGIN_HORIZONE)
            make.bottom.equalTo(kFIT_INSTANCE.fitHeight(height: -15.0))
            make.width.equalTo(kFIT_INSTANCE.fitWidth(width: 60.0))
        }
    }
    
    func configCellWith(model:CNContact) -> Void {
//        self.avatarImageView.image =
        self.nameLabel.text = String.init(format: "%@%@", model.familyName,model.givenName)
        self.phoneButton.setTitle(model.phoneNumbers.first?.value.stringValue, for: UIControl.State.normal)
    }

    
    @objc func invite() -> Void {
        print("邀请加入家谱")
    }
    
    
    func getPhoneNumber(numbers:[CNLabeledValue<CNPhoneNumber>]) -> String {
        var phoneString = String()
        for phone in numbers {
            //获得标签名（转为能看得懂的本地标签名，比如work、home）
            var label = "未知标签"
            if phone.label != nil {
                label = CNLabeledValue<NSString>.localizedString(forLabel:
                    phone.label!)
            }
            //获取号码
            let value = phone.value.stringValue
            print("\t\(label)：\(value)")
            if !value.isEmpty {
                phoneString = value
                break
            }
        }
        return phoneString
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = self.handlerButton.backgroundColor
        super.setSelected(selected, animated: animated)
        self.handlerButton.backgroundColor = color
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = self.handlerButton.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        self.handlerButton.backgroundColor = color
    }

}
