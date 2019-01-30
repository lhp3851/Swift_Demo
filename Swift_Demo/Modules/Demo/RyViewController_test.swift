//
//  RyViewController_test.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/25.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyViewController_test: UIViewController {

    let items = ["唑吡坦(思诺思)","扎来普隆","佐匹克隆","三唑仑","咪达唑仑",
                 "氟西泮","硝西泮","艾司唑仑","阿普唑仑（佳乐定）","劳拉西泮","度洛西汀（欣百达）",
                 "帕罗西汀（塞乐特）","奥氮平","美利曲辛（黛利新）", "其他"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(pickerView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerView.frame = CGRect(x: 0, y: 200, width: view.bounds.width, height: 300)
    }

    lazy var ryPickerView:RyPickerView = {
        let temp = RyPickerView.medicationRecord
        return temp
    }()
    
    lazy var pickerView: UIPickerView = {
        let temp = UIPickerView()
        temp.dataSource = self
        temp.delegate = self
        return temp
    }()
}

extension RyViewController_test: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return items[row]
    }
}
