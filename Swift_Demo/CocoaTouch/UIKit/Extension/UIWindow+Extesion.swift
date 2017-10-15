//
//  UIWindow+Extesion.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/22.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import Foundation
import UIKit


extension UIWindow {
    
    class func translucentWindow(level:UIWindowLevel, color:UIColor) -> UIWindow? {
        let normalWindow = UIWindow.init(frame: CGRect.init(x: 0, y: 0, width: kWINDOW_WIDTH, height: kWINDOW_HEIGHT))
        normalWindow.windowLevel = level
        normalWindow.backgroundColor = color
        normalWindow.makeKeyAndVisible()
        return normalWindow
    }
    
    
    // 找到当前显示的window
     class func getCurrentWindow() -> UIWindow? {
             // 找到当前显示的UIWindow
             var window: UIWindow? = UIApplication.shared.keyWindow
             /**
               window有一个属性：windowLevel
               当 windowLevel == UIWindowLevelNormal 的时候，表示这个window是当前屏幕正在显示的window
               */
             if window?.windowLevel != UIWindowLevelNormal {
        
                     for tempWindow in UIApplication.shared.windows {
            
                             if tempWindow.windowLevel == UIWindowLevelNormal {
                
                                     window = tempWindow
                                     break
                                 }
                         }
                 }
    
             return window
     }
    
    // MARK: 获取当前屏幕显示的viewController
     class func getCurrentViewController() -> UIViewController? {
    
        // 1.找到当前显示的UIWindow
        let window: UIWindow? = self.getCurrentWindow()
        
         // 2.声明UIViewController类型的指针
         var viewController: UIViewController? = window?.rootViewController

         // 3.获得当前显示的UIWindow展示在最上面的view
         let frontView = window?.subviews.first

         // 4.找到这个view的nextResponder
         let nextResponder = frontView?.next
    
         if nextResponder?.isKind(of: UITabBarController.self) == true {
            let tempTabVC = nextResponder as? UITabBarController
            let tempNavVC  = tempTabVC?.selectedViewController as! UINavigationController
            viewController = tempNavVC.visibleViewController
         }
         else if nextResponder?.isKind(of: UINavigationController.self) == true {
            let tempVC = nextResponder as? UINavigationController
            viewController = tempVC?.visibleViewController
        }
        
        return viewController
     }
    
    
    class func topViewController() -> UIViewController? {
        
             return self.topViewControllerWithRootViewController(viewController: self.getCurrentWindow()?.rootViewController)
        
     }

    class func topViewControllerWithRootViewController(viewController :UIViewController?) -> UIViewController? {
    
             if viewController == nil {
        
                     return nil
                 }
             if viewController?.presentedViewController != nil {
        
                     return self.topViewControllerWithRootViewController(viewController: viewController?.presentedViewController!)
             }
             else if viewController?.isKind(of: UITabBarController.self) == true {
        
                     return self.topViewControllerWithRootViewController(viewController: (viewController as! UITabBarController).selectedViewController)
             }
             else if viewController?.isKind(of: UINavigationController.self) == true {
        
                     return self.topViewControllerWithRootViewController(viewController: (viewController as! UINavigationController).visibleViewController)
             }
             else {
                     return viewController
                 }
         }
    
}
