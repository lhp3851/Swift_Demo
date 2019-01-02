//
//  RyViewController_test.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/25.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class RyViewController_test: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ryPickerView.show()
    }

    lazy var ryPickerView:RyPickerView = {
        let temp = RyPickerView.medicationRecord
        return temp
    }()
}
