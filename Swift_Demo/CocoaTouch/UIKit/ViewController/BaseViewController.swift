//
//  BaseViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/12.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initData()
        self.initPannel()
    }

    func initPannel() -> Void {
        self.view.backgroundColor = UIColor.white
    }
    
    func initData() -> Void {
//        self.navigationItem.title = NSStringFromClass(object_getClass(self)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
