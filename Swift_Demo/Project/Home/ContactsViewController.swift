//
//  ContactsViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/14.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit


class ContactsViewController: BaseViewController {

    var contacts = Array<Any>()
    lazy var contactsView : ContactsView = {
        let view = ContactsView.init(frame: CGRect.zero, tableViewDelegate:nil)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func initPannel() {
        super.initPannel()
        self.view.addSubview(self.contactsView)
        ContactsTool.getContacts { (contacts) in
            self.contactsView.datas = contacts
            self.contactsView.contactsTableview.reloadData()
        }
        self.setConstraints()
    }
    
    override func initData() {
        super.initData()
        self.navigationItem.title = "通讯录"
    }
    
    func setConstraints() -> Void {
        self.contactsView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
