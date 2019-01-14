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
    
    struct Addresses {
        static var defaultDatas:[[String:Any]] = {
            let path = Bundle.main.path(forResource: "areas", ofType: "json")
            let contents = FileManager.default.contents(atPath: path!)
            let address = try! JSONSerialization.jsonObject(with: contents!, options: JSONSerialization.ReadingOptions.allowFragments)
            return address as! [[String : Any]]
        }()
        
        static var provinces:[String] = {
            var temp = [String]()
            for item in defaultDatas {
                temp.append(item["name"] as! String)
            }
            return temp
        }()
        
        static var cities:[String] {
            return getCities()
        }
        
        static var areas:[String] {
            return getArea(city: "北京市", province: "北京市")
        }
        
        static func getCities(province:String = "北京市") -> [String] {
            var temp = [String]()
            for item in defaultDatas {
                if let provinceItem:String = item["name"] as? String,provinceItem == province {
                    let cityItemes:[[String:Any]] = item["city"] as! [[String:Any]];
                    for cityItem in cityItemes {
                        temp.append(cityItem["name"] as! String)
                    }
                    break
                }
            }
            return temp
        }
        
        static func getArea(city:String = "深圳市" ,province:String = "广东省") -> [String] {
            var temp = [String]()
            for item in defaultDatas {
                if let provinceItem:String = item["name"] as? String,provinceItem == province {
                    let cityItemes:[[String:Any]] = item["city"] as! [[String:Any]];
                    for cityItem in cityItemes {
                        if let currentCity:String = cityItem["name"] as? String , city == currentCity {
                            let areas:[String] = cityItem["area"] as! [String]
                            for areaItem in areas {
                                temp.append(areaItem)
                            }
                            break
                        }
                    }
                }
            }
            return temp
        }
    }
    
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
        let frame = CGRect.init(x: 15, y: kNAVIGATION_STATU_BAR_HEIGHT + 20, width: kWINDOW_WIDTH - 30, height: 30)
        let temp = KKLabel.init(frame: frame)
        temp.textAlignment = .left
        temp.backgroundColor = kCOLOR_NOTTOUCH
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
        
        let chinese : String = "Swift 是一种新的编程语言，用于编写 iOS 和 OS X 应用。\nSwift 是一种新的编程语言，用于编写 iOS 和 OS X 应用。Swift 是一种新的编程语言，用于编写 iOS 和 OS X 应用。\n"
        let index =  chinese.index(of: "是")
        let result = chinese.reversed()
        print(chinese.startIndex,chinese.endIndex,chinese.count,"index:",index!,result)
        
        contetLabel.text = chinese
//        contetLabel.textWithWidth(width: contetLabel.frame.width)
        contetLabel.adjustFrame()
    }
    
    @objc func getContacts() {
        let contactsVC = ContactsViewController()
        BaseViewController.jumpViewController(sourceViewConrroller: self, destinationViewController: contactsVC, animated: true)
    }
    
    
    @objc func scanQRcode(){
        let QRcodeVC = QRCodeViewController()
        BaseViewController.jumpViewController(sourceViewConrroller: self, destinationViewController: QRcodeVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print(index)
    }

}
