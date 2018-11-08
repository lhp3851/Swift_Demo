//
//  StorePageViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/19.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class StorePageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func initPannel() {
        super.initPannel()
    }
    
    override func initData() {
        super.initData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.openAppStoreWith(appID: "1252223318") {
            print("open ok!")
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
