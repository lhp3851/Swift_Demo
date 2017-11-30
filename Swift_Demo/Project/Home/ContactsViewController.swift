//
//  ContactsViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/14.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: BaseViewController,UISearchControllerDelegate,UISearchResultsUpdating,UISearchDisplayDelegate {

    var contacts = Array<Any>()
    lazy var contactsView : ContactsView = {
        let view = ContactsView.init(frame: CGRect.zero, tableViewDelegate:nil)
        return view
    }()
    
    lazy var searchList : [[CNContact]] = [[CNContact]]()
    lazy var dataList : [[CNContact]] = [[CNContact]]()
    
    @available(iOS 9.1, *)
    lazy var searchController : UISearchController = {
        let VC = UISearchController.init(searchResultsController: nil)
        VC.delegate = self
        VC.searchResultsUpdater = self
        VC.searchBar.text = "Jerry"
        VC.searchBar.placeholder = "搜索"
        VC.dimsBackgroundDuringPresentation = true
        VC.obscuresBackgroundDuringPresentation = true
        VC.hidesNavigationBarDuringPresentation = false
        return VC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func initPannel() {
        super.initPannel()
        if #available(iOS 9.1, *) {
            self.contactsView.contactsTableview.tableHeaderView = self.searchController.searchBar
        } else {
            
        }
        self.view.addSubview(self.contactsView)
        self.setConstraints()
//        self.definesPresentationContext = true
    }
    
    override func initData() {
        super.initData()
        self.navigationItem.title = "通讯录"
        
        ContactsTool.getContacts { (contacts) in
            self.dataList = contacts
            self.reloadDatas(contacts: contacts)
        }
    }
    
    func setConstraints() -> Void {
        self.contactsView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let serachOption : NSPredicate = NSPredicate.init(format: "SELF CONTAINS[c] %@", searchText!)
        if self.searchList.count > 0  {
            self.searchList.removeAll()
        }
        
//        self.searchList = self.dataList.filter({ (contacts) -> Bool in
//            let loaclContacts : [CNContact] = contacts
//            for contact in loaclContacts {
//                if contacts.name
//            }
//            return false
//        })
        self.reloadDatas(contacts: self.searchList)
    }
    
    // MARK: - UISearchControllerDelegate
    func willPresentSearchController(_ searchController: UISearchController) {
        
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        self.reloadDatas(contacts: self.dataList)
    }
    
    // MARK: - UISearchDisplayDelegate
    
    // MARK: - reloadDatas
    func reloadDatas(contacts:[[CNContact]]) -> Void {
        self.contactsView.datas = contacts
        DispatchQueue.main.async(execute: {
            self.contactsView.contactsTableview.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
