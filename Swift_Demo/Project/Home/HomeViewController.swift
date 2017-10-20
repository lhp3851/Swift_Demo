//
//  HomeViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/12.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HomeViewController: BaseViewController {

    lazy var activityView:NVActivityIndicatorView = {
        let view = ProgressHUDTool.activityView
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func initPannel() {
        super.initPannel()
        self.navigationItem.leftBarButtonItem = BarButtonItem().itemWithType(type: .BarButtomeTypePhone, title: "", selector: #selector(getContacts), target: self)
        
        self.view.addSubview(self.activityView)
        self.activityView.startAnimating()
        
        ProgressHUDTool.showHUD(toView: self.view)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            ProgressHUDTool.hieHUD(view: self.view)
        }
    }
    
    
    override func initData() {
        super.initData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.activityView.stopAnimating()
        }
        
    }
    
    @objc func getContacts() {
        let contactsVC = ContactsViewController()
        BaseViewController.jumpViewController(sourceViewConrroller: self, destinationViewController: contactsVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
