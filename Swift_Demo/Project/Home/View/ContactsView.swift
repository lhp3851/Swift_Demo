//
//  ContactsView.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/15.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import Contacts

class ContactsView: BaseView,UITableViewDelegate,UITableViewDataSource {
   
    var delegate:UITableViewDelegate?
    var datas = Array<CNContact>()

    lazy var contactsTableview : BaseTableview = {
        let view = BaseTableview.init(frame: CGRect.zero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect,tableViewDelegate:UITableViewDelegate?) {
        super.init(frame: CGRect.zero)
        self.delegate = tableViewDelegate
        self.initPannle()
    }
    
    
    func initPannle() -> Void {
        self.addSubview(self.contactsTableview)
        self.setConstraints()
    }
    
    func setConstraints() -> Void {
        self.contactsTableview.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kFIT_INSTANCE.fitHeight(height: 60.0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifiler = "indentifiler"
        var cell : ContactsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifiler) as? ContactsTableViewCell
        if cell == nil {
            cell = ContactsTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifiler)
        }
        cell?.configCellWith(model: self.datas[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
