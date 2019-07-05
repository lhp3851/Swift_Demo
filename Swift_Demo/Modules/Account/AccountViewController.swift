//
//  AccountViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/15.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AccountViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.rx.observe(CGRect.self, "frame")
            .subscribe { (frame) in
                print("frame:",frame)
        }.dispose()
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
        
    }

}
