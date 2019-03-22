//
//  KKDemoModel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/8.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

class KKDemoModel: KKBaseModel {
    static var groupDatas : [[String:Any]] = {
        let datas = [["UIView":["UIButton","UILabel","UITableView","UIScrollView","UIImageView","WebView"]],
                     ["Archive":["Archive","File","Plist","UserDefault","SQLite","CoreData","KeyChain"]],
                     ["Animate":["BasicAnimate","FrameAnimate","GroupAnimate","TranstionAnimate"]],
                     ["Selector":["Selector"]]]
        return datas
    }()
}
