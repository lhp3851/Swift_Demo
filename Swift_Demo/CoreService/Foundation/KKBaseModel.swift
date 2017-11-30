//
//  KKBaseModel.swift
//  Swift_Demo
//
//  Created by Jerry on 2017/11/21.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class KKBaseModel: NSObject {

    static var groupDatas : [[String]] = {
        let datas = [["UIButton"],["UILabel"],["UITableView"],["UIScrollView"],["UIImageView"],["WebView"]]
        
        return datas
    }()
    
}
