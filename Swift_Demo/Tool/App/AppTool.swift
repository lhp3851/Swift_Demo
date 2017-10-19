//
//  AppTool.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/19.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import StoreKit

protocol AppToolDelegate {
    func completeHandler(viewController:UIViewController) -> Void
}

class AppTool: NSObject,SKStoreProductViewControllerDelegate {

    var tempVC :BaseViewController?
    var delegate : AppToolDelegate?
    
    
    typealias completeBlock = () -> ()
    
    override init() {
        super.init()
        self.delegate = nil
    }

    
    func openAppStoreWith(appID:String,viewController:BaseViewController,block:@escaping completeBlock) -> Void {
        tempVC = viewController
        let storeVC = SKStoreProductViewController()
        storeVC.delegate = self
        let appDic :Dictionary = [SKStoreProductParameterITunesItemIdentifier:appID]
        storeVC.loadProduct(withParameters: appDic) { (complete, error) in
            if error == nil {
                viewController.present(storeVC, animated: true, completion: {
                    block()
                })
            }
            else{
                print("wrong bundleID")
            }
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        self.delegate?.completeHandler(viewController: viewController)
    }
}
