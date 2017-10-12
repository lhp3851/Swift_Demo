//
//  ViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/9/22.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum WeekDays: Int{
        case Monday = 1
        case Tuesday
        case Wednesday
        case Thursday
        case Friday
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(WeekDays.Tuesday.hashValue,WeekDays.Tuesday.rawValue)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let alert = UIAlertController.init(title: "警告框", message: "提示消息", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let actionSure = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.default) { (action) in
            print("yes")
        }
        let actionCancle = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
            print("取消")
        }
        let actionDestruct = UIAlertAction.init(title: "Destruct", style: UIAlertActionStyle.destructive) { (action) in
            print("Destruct")
        }
        
        alert.addAction(actionSure)
        alert.addAction(actionCancle)
        alert.addAction(actionDestruct)
        
        self.present(alert, animated: true) {
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

