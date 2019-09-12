//
//  ViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/9/22.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
        
        _ = self.rx.observe(CGRect.self, "view.frame")
            .subscribe(onNext: { frame in
                print("--- 视图尺寸发生变化 ---")
                print(frame!)
                print("\n")
            })

    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let alert = UIAlertController.init(title: "警告框", message: "提示消息", preferredStyle: UIAlertController.Style.actionSheet)
        
        let actionSure = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default) { (action) in
            print("yes")
        }
        let actionCancle = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel) { (action) in
            print("取消")
        }
        let actionDestruct = UIAlertAction.init(title: "Destruct", style: UIAlertAction.Style.destructive) { (action) in
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

