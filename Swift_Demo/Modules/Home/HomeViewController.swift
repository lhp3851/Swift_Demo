//
//  HomeViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/12.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SDCycleScrollView

class HomeViewController: BaseViewController,SDCycleScrollViewDelegate {
    
    lazy var activityView:NVActivityIndicatorView = {
        let view = ProgressHUDTool.activityView
        return view
    }()
    
    lazy var scrollView : SDCycleScrollView = {
        let infinitFrame = CGRect.init(x: 0, y: 0, width: kWINDOW_WIDTH, height: kFIT_INSTANCE.fitHeight(height: 256))
        let view = SDCycleScrollView.init(frame: infinitFrame, imageNamesGroup: ["image1","image2","image3"])
        view?.autoScrollTimeInterval = 2.0
        view?.pageControlStyle = SDCycleScrollViewPageContolStyle.init(1)
        view?.delegate = self
        return view!
    }()
    
    lazy var infinitView : KKScrollView = {
        let infinitFrame = CGRect.init(x: 0, y: self.scrollView.frame.maxY + 20.0, width: kWINDOW_WIDTH, height: kFIT_INSTANCE.fitHeight(height: 256))
        let view = KKScrollView.init(frame: infinitFrame, needControl: true)
        return view
    }()
    
    lazy var contetLabel:KKLabel = {
        let frame = CGRect.init(x: 15, y: 15 + kNAVIGATION_STATU_BAR_HEIGHT, width: kWINDOW_WIDTH - 30, height: 30)
        let temp = KKLabel.init(frame: frame)
        temp.textAlignment = .left
        temp.backgroundColor = kCOLOR_NOTTOUCH
        temp.numberOfLines = 0
        temp.lineBreakMode = NSLineBreakMode.byClipping
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func initPannel() {
        super.initPannel()
        self.view.backgroundColor = kCOLOR_BACKGROUND
        self.navigationItem.leftBarButtonItem = BarButtonItem().itemWithType(type: .BarButtomeTypePhone, title: "", selector: #selector(getContacts), target: self)
        self.navigationItem.rightBarButtonItem = BarButtonItem().itemWithType(type: .BarButtomeTypeQRCode, title: "", selector: #selector(scanQRcode), target: self)
        self.view.addSubview(contetLabel)
    }
    
    
    override func initData() {
        super.initData()
        
        let chinese : String = "Swift 是一种新的编程语言，用于编写 iOS 和 OS X 应用。Swift 是一种新的编程语言，用于编写 iOS 和 OS X 应用。Swift 是一种新的编程语言，用于编写 iOS 和 OS X 应用。\n "
        let index =  chinese.index(of: "是")
        let result = chinese.reversed()
        print(chinese.startIndex,chinese.endIndex,chinese.count,"index:",index!,result)
        
        contetLabel.text = chinese + chinese
        contetLabel.sizeToFit()
    }
    
    @objc func getContacts() {
        let contactsVC = ContactsViewController()
        BaseViewController.jumpViewController(sourceViewConrroller: self, destinationViewController: contactsVC, animated: true)
    }
    
    
    @objc func scanQRcode(){
        let QRcodeVC = QRCodeViewController()
        BaseViewController.jumpViewController(sourceViewConrroller: self, destinationViewController: QRcodeVC, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print(index)
    }
    
    @objc func injected(){
        
        print("I've been injected: \(self)")
        
    }

}
