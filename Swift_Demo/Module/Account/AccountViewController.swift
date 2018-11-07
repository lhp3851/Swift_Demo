//
//  AccountViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/15.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func initPannel() {
        super.initPannel()

    }
    
    override func initData() {
        super.initData()
        self.navigationItem.title = String.locallized(locallized: "kLOGIN")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
