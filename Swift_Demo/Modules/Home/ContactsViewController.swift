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
        VC.searchBar.placeholder = "搜索"
        VC.dimsBackgroundDuringPresentation = false
        VC.searchBar.tintColor = kCOLOR_BUTTON_NORMOL
        VC.searchBar.setValue("完成", forKeyPath: "_cancelButtonText")
//        VC.obscuresBackgroundDuringPresentation = false
//        VC.hidesNavigationBarDuringPresentation = false
        VC.searchBar.backgroundColor = kCOLOR_BACKGROUND
        VC.searchBar.barTintColor = kCOLOR_BACKGROUND
        VC.searchBar.subviews.first?.subviews.first?.removeFromSuperview()
        let textFiled : UITextField = VC.searchBar.value(forKey: "_searchField") as! UITextField
        textFiled.setValue("1", forKeyPath: "_placeholderLabel.textAlignment")
        textFiled.textAlignment = NSTextAlignment.left
        textFiled.setValue(kCOLOR_BUTTON_HEIGHT, forKeyPath: "_placeholderLabel.textColor")
        textFiled.font = kFONT_16
        VC.searchBar.scopeButtonTitles = ["true"]
        VC.searchBar.showsScopeBar = true
        VC.searchBar.showsSearchResultsButton = true
        VC.searchBar.showsBookmarkButton = true
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
        self.definesPresentationContext = true
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
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.isEmpty {
            return
        }
        let searchOption : NSPredicate = NSPredicate.init(format: "SELF CONTAINS[cd] %@", searchText)
        if self.searchList.count > 0  {
            self.searchList.removeAll()
        }

        self.searchList = self.dataList.filter({ (contacts) -> Bool in
            for contact:CNContact in contacts {
                return searchOption.evaluate(with: contact.familyName + contact.givenName)
            }
            return false
        })
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
