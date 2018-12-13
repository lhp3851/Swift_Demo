//
//  KKStaturePickerView.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/28.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKStaturePickerView: KKPickerSubView {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(frame: CGRect, needUnits: Bool) {
        super.init(frame: frame, needUnits: needUnits)
    }
    
    override var datas: [[String]]! {
        var dataSource = [[String]]()
        let model = KKStaturePickerModel().datas as! [String]
        dataSource.append(model)
        return dataSource
    }


}

