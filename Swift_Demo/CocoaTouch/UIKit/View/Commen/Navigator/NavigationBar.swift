//
//  NavigationBar.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/12.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit


enum BarButtomeType {
    case BarButtomeTypeBack
    
    case BarButtomeTypeQRCode
    
    case BarButtomeTypeMessage
    
    case BarButtomeTypePhone
    
    case BarButtomeTypeWithTitle
    
    case BarButtomeTypeSearch
    
    case BarButtomeTypeOther
    
    case BarButtomeTypeCancle
}


class NavigationBar: UINavigationBar {

   

}


class NavigationItem: UINavigationItem {
    
    
    
}


class BarButtonItem: UIBarButtonItem {
   
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var QRCodeItem : UIBarButtonItem = { () -> UIBarButtonItem in
        let image = FilesManagerTool.imageWithNames(imageName: "sweep_icon")
        let selector : Selector = #selector(normalSelector)
        let QRCodeBarItem = UIBarButtonItem.init(image: image, style: UIBarButtonItemStyle.done, target: self, action: selector);
        return QRCodeBarItem;
    }()
    
    
    lazy var messageItem :UIBarButtonItem = { () -> UIBarButtonItem in
        let image = FilesManagerTool.imageWithNames(imageName: "news_icon")
        let selector : Selector = #selector(normalSelector)
        let messageBarItem = UIBarButtonItem.init(image: image, style: UIBarButtonItemStyle.done, target: self, action: selector);
        return messageBarItem;
    }()
    
   
    lazy var phoneItem :UIBarButtonItem = { () -> UIBarButtonItem in
        let image = FilesManagerTool.imageWithNames(imageName: "call_icon")
        let selector : Selector = #selector(normalSelector)
        let phoneBarItem = UIBarButtonItem.init(image: image, style: UIBarButtonItemStyle.done, target: self, action: selector);
        return phoneBarItem;
    }()
    
    lazy var searchItem :UIBarButtonItem = { () -> UIBarButtonItem in
        let image = FilesManagerTool.imageWithNames(imageName: "seach_icon")
        let selector : Selector = #selector(normalSelector)
        let searchBarItem = UIBarButtonItem.init(image: image, style: UIBarButtonItemStyle.done, target: self, action: selector);
        return searchBarItem;
    }()
    
    lazy var backItem :UIBarButtonItem = { () -> UIBarButtonItem in
        let image = FilesManagerTool.imageWithNames(imageName: "back_white_icon")
        let selector : Selector = #selector(normalSelector)
        let backBarItem = UIBarButtonItem.init(image: image, style: UIBarButtonItemStyle.done, target: self, action: selector);
        return backBarItem;
    }()
    
    lazy var otherItem :UIBarButtonItem = { () -> UIBarButtonItem in
        let image = FilesManagerTool.imageWithNames(imageName: "more_icon")
        let selector : Selector = #selector(normalSelector)
        let otherBarItem = UIBarButtonItem.init(image: image, style: UIBarButtonItemStyle.done, target: self, action: selector);
        return otherBarItem;
    }()
    
    lazy var normalTextItem :UIBarButtonItem = { () -> UIBarButtonItem in
        let selector : Selector = #selector(normalSelector)
        let normalTextBarItem = UIBarButtonItem.init(title: "推送设置", style: UIBarButtonItemStyle.done, target: self, action: selector);
        normalTextBarItem.setTitleTextAttributes({[NSAttributedStringKey.foregroundColor:kCOLOR_WHITE,NSAttributedStringKey.font:kFONT_16]}(), for: UIControlState.normal)
        return normalTextBarItem;
    }()
    
    lazy var cancleItem :UIBarButtonItem = { () -> UIBarButtonItem in
        let image = FilesManagerTool.imageWithNames(imageName: "close_icon")
        let selector : Selector = #selector(normalSelector)
        let cancleItem = UIBarButtonItem.init(image: image, style: UIBarButtonItemStyle.done, target: self, action: selector);
        return cancleItem;
    }()
    
    
    @objc func normalSelector(button:UIButton) -> Void {
        print("统一方法")
    }
    
    func itemWithType(type:BarButtomeType, title:String, selector:Selector, target:Any?) -> UIBarButtonItem {
        switch type {
        case .BarButtomeTypeQRCode:
        
            QRCodeItem.target = target as AnyObject
            QRCodeItem.action = selector
            return QRCodeItem
           
        case .BarButtomeTypeMessage:
            
            messageItem.target = target as AnyObject
            messageItem.action = selector
            return messageItem
            
        case .BarButtomeTypePhone:
            
            phoneItem.target = target as AnyObject
            phoneItem.action = selector
            return phoneItem
            
        case .BarButtomeTypeWithTitle:
            
            normalTextItem.title = title
            normalTextItem.target = target as AnyObject
            normalTextItem.action = selector
            return normalTextItem
            
        case .BarButtomeTypeSearch:
            
            searchItem.target = target as AnyObject
            searchItem.action = selector
            return searchItem
            
        case .BarButtomeTypeBack:
            
            backItem.target = target as AnyObject
            backItem.action = selector
            return backItem
    
        case .BarButtomeTypeOther:
            
            otherItem.target = target as AnyObject
            otherItem.action = selector
            return otherItem
            
        case .BarButtomeTypeCancle:
            
            cancleItem.target = target as AnyObject
            cancleItem.action = selector
            return cancleItem
            
        }
    }
    
}
