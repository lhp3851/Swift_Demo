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
    var messyDatas = [CNContact]()
    var datas : [[CNContact]] {
        get{
            let temp = self.sortContacts(contacts: self.messyDatas)
            return temp
        }
    }
    
    var localizedCollation:UILocalizedIndexedCollation = UILocalizedIndexedCollation.current()
    var indexTitiles = Array<String>()

    lazy var contactsTableview : BaseTableview = {
        let view = BaseTableview.init(frame: CGRect.zero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        view.sectionIndexColor = kCOLOR_BUTTON_NORMOL
        view.sectionIndexBackgroundColor = kCOLOR_CLEAR
        view.sectionIndexTrackingBackgroundColor = kCOLOR_BUTTON_HEIGHT
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
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.indexTitiles.count
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
            cell = ContactsTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifiler)
        }
        cell?.configCellWith(model: self.datas[indexPath.section][indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func sortContacts(contacts:[CNContact]) -> [[CNContact]]{
        var tempContactsArray = [[CNContact]]()
        
        for _ in 0..<self.localizedCollation.sectionTitles.count {
            let array:[CNContact] = Array()
            tempContactsArray.append(array)
        }
        
        for contact in contacts {
            let section = self.localizedCollation.section(for: contact, collationStringSelector: #selector(getter: contact.familyName))
            var tempArray : [CNContact] = tempContactsArray[section]
            tempArray.append(contact)
            tempContactsArray[section] = tempArray
        }
        
        let tempContacts = tempContactsArray
        for i in 0..<self.indexTitiles.count {
            let sectionContacts = tempContacts[i]
            let sortedContactsForSection = self.localizedCollation.sortedArray(from: sectionContacts, collationStringSelector:  #selector(getter: CNContact.familyName))
            tempContactsArray[i] = sortedContactsForSection as! [CNContact]
        }
        return tempContactsArray
    }
    
}
