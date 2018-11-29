//
//  KKDatePickerView.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKDatePickerView: KKPickerSubView {

    lazy var pickerView:UIDatePicker = {
        let temp = UIDatePicker()
        temp.datePickerMode = .date
        temp.maximumDate = Date()
        temp.minimumDate = Date.init(timeIntervalSince1970: 0)
        temp.locale = Locale.init(identifier: "zh_Hans_CN")
        temp.timeZone = TimeZone.init(identifier: "CST")
        temp.calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        return temp
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPannel()
        addLayOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPannel()  {
        addSubview(pickerView)
    }
    
    func addLayOut()  {
        pickerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    
}
