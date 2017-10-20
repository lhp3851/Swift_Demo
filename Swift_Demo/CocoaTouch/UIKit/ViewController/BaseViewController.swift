//
//  BaseViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/12.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import Reachability
import StoreKit

class BaseViewController: UIViewController {
    typealias NetWorkChangedClosure = () -> Void
    typealias NetWorkStatus = () -> Void
    
    let reachability = Reachability()!
    var isNetWorkReachable = (Reachability()?.connection != .none)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.defualtSetting()
        self.initData()
        self.initPannel()
        self.listenNetWork()
    }
    
    func defualtSetting() -> Void {
        self.edgesForExtendedLayout = UIRectEdge.all
        self.automaticallyAdjustsScrollViewInsets = false
        self.extendedLayoutIncludesOpaqueBars = false
    }
    
    func initPannel () -> Void {
        self.view.backgroundColor = kCOLOR_WHITE
        self.navigationItem.backBarButtonItem = BarButtonItem().itemWithType(type: BarButtomeType.BarButtomeTypeBack, title: "", selector: #selector(pop(toViewController:)), target: self);
    }
    
    func initData() -> Void {
        
    }
    
    
    func listenNetWork() -> Void {
        do {
            
            try reachability.startNotifier()
            
        } catch {
            
            print("Unable to start notifier \(self)")
            
        }
    }
    
    func loadDataIfNetWorkWithReacablity(isReachable : @escaping NetWorkStatus,unReachable:@escaping NetWorkStatus) -> Void {
        
        if reachability.connection != .none {
            isReachable()
        }
        else{
            unReachable()
        }
        
    }
    
    
    func netWorkChanged(netWorkChangedClosure closure: @escaping NetWorkChangedClosure) -> Void {
        
        reachability.whenReachable = { reachability in
            
            DispatchQueue.main.async {
                
                if reachability.connection == .wifi {
                    
                    print("Reachable via WiFi \(self)")
                    
                } else {
                    
                    print("Reachable via Cellular \(self)")
                    
                }
                
                self.isNetWorkReachable = true
                
                closure()
            }
        }
        
        reachability.whenUnreachable = { reachability in
            
            DispatchQueue.main.async {
                
                print("Not reachable \(self)")
            }
            
            self.isNetWorkReachable = false
            
            closure()
        }
        
    }
    
    
    
    class func jumpViewController(sourceViewConrroller:BaseViewController,destinationViewController:BaseViewController,animated:Bool) -> Void {
        if (!destinationViewController.hidesBottomBarWhenPushed) {
            
            destinationViewController.hidesBottomBarWhenPushed = true
            
        }
        sourceViewConrroller.navigationController!.pushViewController(destinationViewController, animated: animated)
    }
    
    
    func cancelRequest(requests:[NetWorkTool.RequestTask]) -> Void {
        for request:NetWorkTool.RequestTask in requests {
            request.cancel()
        }
    }
    
    @objc func pop(toViewController:BaseViewController?) -> Bool {
        var VC : UIViewController?
        
        if let  viewController = toViewController,viewController.isKind(of: BaseViewController.self) {
            let viewContrllers = self.navigationController?.popToViewController(viewController, animated: true)
            VC = viewContrllers?.last
        }
        else{
            VC = self.navigationController?.popViewController(animated: true)
        }
        
        if VC != nil {
            return true
        }
        else{
            return false
        }
        
    }
    
    
    func setBack() -> Void {
        // 返回按钮
        let backButton = UIButton(type: .custom)
        
        // 给按钮设置返回箭头图片
        backButton.setBackgroundImage(kIMAGE_WITH(name: "back_white_icon"), for: .normal)
        
        // 设置frame
        backButton.frame = CGRect(x: 200, y: 13, width: 18, height: 18)
        backButton.addTarget(self, action: #selector(pop(toViewController:)), for: .touchUpInside)
        
        // 自定义导航栏的UIBarButtonItem类型的按钮
        let backView = UIBarButtonItem(customView: backButton)
        
        // 重要方法，用来调整自定义返回view距离左边的距离
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = -5
        
        // 返回按钮设置成功
        navigationItem.leftBarButtonItems = [barButtonItem, backView]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension BaseViewController:SKStoreProductViewControllerDelegate {
    
    typealias completeBlock = () -> ()
    
    func openAppStoreWith(appID:String,block:@escaping completeBlock) -> Void {
        let storeVC = SKStoreProductViewController()
        storeVC.delegate = self
        let appDic :Dictionary = [SKStoreProductParameterITunesItemIdentifier:appID]
        storeVC.loadProduct(withParameters: appDic) { (complete, error) in
            if error == nil {
                self.present(storeVC, animated: true, completion: {
                    block()
                })
            }
            else{
                print("wrong bundleID")
            }
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: {
            
        })
    }
    
}




