//
//  ProfileViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/12.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    lazy var profileView:ProfileViewes = {
        let view = ProfileViewes.init(frame: CGRect.zero)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func initPannel() {
        super.initPannel()
        self.view.addSubview(self.profileView)
        self.setConstraints()
    }
    
    func setConstraints() -> Void {
        self.profileView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    override func initData() {
        super.initData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

   

}
