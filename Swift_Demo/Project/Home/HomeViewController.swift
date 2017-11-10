//
//  HomeViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/12.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HomeViewController: BaseViewController,KKPageControlDelegate {
    lazy var activityView:NVActivityIndicatorView = {
        let view = ProgressHUDTool.activityView
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func initPannel() {
        super.initPannel()
        self.view.backgroundColor = kCOLOR_BACKGROUND
        self.navigationItem.leftBarButtonItem = BarButtonItem().itemWithType(type: .BarButtomeTypePhone, title: "", selector: #selector(getContacts), target: self)
        
//        self.view.addSubview(self.activityView)
//        self.activityView.startAnimating()

        self.navigationItem.rightBarButtonItem = BarButtonItem().itemWithType(type: .BarButtomeTypeQRCode, title: "", selector: #selector(scanQRcode), target: self)
        self.view.addSubview(self.activityView)
        self.activityView.startAnimating()
        
//        ProgressHUDTool.showHUD(toView: self.view)
    
        let frame = CGRect.init(x: kMARGIN_HORIZONE, y: 104.0, width: kWINDOW_WIDTH - kMARGIN_HORIZONE*2, height: 80.0)
        let pageControl = KKPageControl.init(frame: frame , count: 5, selectedType: KKPageControlType.LineWithCap, normalType: KKPageControlType.Dot,postionType:KKPageControlPosition.Left)
        pageControl.delegate = self
        pageControl.normalColor = kCOLOR_BUTTON_NORMOL
        pageControl.selectedColor = kCOLOR_SAFELY
        self.view.addSubview(pageControl)
    }
    
    
    override func initData() {
        super.initData()
        
        let chinese : String = "Swift 是一种新的编程语言，用于编写 iOS 和 OS X 应用。"
        let index =  chinese.index(of: "是")
        let result = chinese.reversed()
        print(chinese.startIndex,chinese.endIndex,chinese.characters.count,"index:",index,result)
        
        let chinese_suf = chinese.suffix(2)
        let chinese_pre = chinese.prefix(2)
        print(chinese_pre,chinese_suf)
        
//        let chinese_sub = chinese.substring(to: chinese.startIndex + 3)
//        for char in chinese.characters {
//            print(char)
//        }
    }
    
    @objc func getContacts() {
        let contactsVC = ContactsViewController()
        BaseViewController.jumpViewController(sourceViewConrroller: self, destinationViewController: contactsVC, animated: true)
    }
    
    //MARK:KKPageControlDelegate
    func clicked(control: KKPageControl) {
        print("control:",control)
    }
    
    
    @objc func scanQRcode(){
        let QRcodeVC = QRCodeViewController()
        BaseViewController.jumpViewController(sourceViewConrroller: self, destinationViewController: QRcodeVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
