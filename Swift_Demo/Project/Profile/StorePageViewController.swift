//
//  StorePageViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/19.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class StorePageViewController: BaseViewController,AppToolDelegate {

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
        let appTool = AppTool()
        appTool.delegate = self
        appTool.openAppStoreWith(appID: "1252223318", viewController: self) {
            print("open ok!")
        }
        
    }
    
    func completeHandler(viewController: UIViewController) {
        viewController.dismiss(animated: true) {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
