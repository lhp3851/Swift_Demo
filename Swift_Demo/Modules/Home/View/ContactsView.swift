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
    var datas : [[CNContact]] = [[CNContact]]()
    
    var localizedCollation:UILocalizedIndexedCollation = UILocalizedIndexedCollation.current()
    var indexTitiles = Array<String>()

    lazy var contactsTableview : BaseTableview = {
        let view = BaseTableview.init(frame: CGRect.zero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = kCOLOR_BACKGROUND
        view.sectionIndexColor = kCOLOR_BUTTON_NORMOL
        view.sectionIndexBackgroundColor = kCOLOR_CLEAR
        view.sectionIndexTrackingBackgroundColor = kCOLOR_BUTTON_HEIGHT
        view.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect,tableViewDelegate:UITableViewDelegate?) {
        super.init(frame: CGRect.zero)
        self.delegate = tableViewDelegate
        self.initPannle()
        self.initData()
    }
    
    
    func initPannle() -> Void {
        self.addSubview(self.contactsTableview)
        self.setConstraints()
    }
    
    func initData() -> Void {
        self.indexTitiles = self.localizedCollation.sectionIndexTitles
    }
    
    func setConstraints() -> Void {
        self.contactsTableview.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return min(self.indexTitiles.count, datas.count)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kFIT_INSTANCE.fitHeight(height: 60.0)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let contacts = self.datas[section]
        if contacts.count > 0 {
            return kFIT_INSTANCE.fitHeight(height: 30.0)
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headView : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headView.contentView.backgroundColor = kCOLOR_BACKGROUND
        headView.textLabel?.textColor = kCOLOR_BUTTON_NORMOL
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contacts = self.datas[section]
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if  self.datas[section].count <= 0  {
            return nil
        }
        else {
            return UILocalizedIndexedCollation.current().sectionTitles[section]
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.indexTitiles 
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifiler = "indentifiler"
        var cell : ContactsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifiler) as? ContactsTableViewCell
        if cell == nil {
            cell = ContactsTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifiler)
        }
        cell?.configCellWith(model: self.datas[indexPath.section][indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
}
