//
//  KKTimePickerDataSource.swift
//  Swift_Demo
//
//  Created by sumian on 2018/12/17.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKTimePickerDataSource: KKPickerViewDataSource {
    
    var collumns: Int = 2
    
    var title: String = "时间"
    
    var uinits: String = ""
    
    var defaultIndex: [Int] = [0]
    
    var cellSize: CGSize = CGSize.zero
    
    var datas: [Any] = []
    
    
}
