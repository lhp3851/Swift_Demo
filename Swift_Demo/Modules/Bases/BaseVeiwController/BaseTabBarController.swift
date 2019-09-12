//
//  BaseTabBarController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/12.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initPannle()
        setItemAttribute()
    }

    func initPannle() -> Void {
        self.tabBar.shadowImage = UIImage.init(color: UIColor.kTRANSLUCENT, size: CGSize.init(width: UIScreen.width, height: 0.1))
        self.tabBar.backgroundImage = UIImage.init(color: UIColor.kWHITE, size: CGSize.init(width: UIScreen.width, height: BaseViewController().kTAB_BAR_HEIGHT))
        composeViewControllers()
    }
    
    
    func composeViewControllers()  {
        let homeVC = HomeViewController()
        let homeNav = BaseNavigationViewController.init(rootViewController: homeVC)
        homeNav.tabBarItem.itemWithImage(title: "首页", image: "home-page_icon_normal", selectedImage: "home-page_icon_select")
        
        let genealogyVC = GenealogyViewController()
        let genealogyNav = BaseNavigationViewController.init(rootViewController: genealogyVC)
        genealogyNav.tabBarItem.itemWithImage(title: "家谱", image: "praise_icon_normal", selectedImage: "praise_icon_select")
        
        let traceVC = TraceViewController()
        let traceNav = BaseNavigationViewController.init(rootViewController: traceVC)
        traceNav.tabBarItem.itemWithImage(title: "事迹", image: "activity_icon_normal", selectedImage: "activity_icon_select")
        
        let pofileVC = ProfileViewController()
        let pofileNav = BaseNavigationViewController.init(rootViewController: pofileVC)
        pofileNav.tabBarItem.itemWithImage(title: "我的", image: "mine_icon_normal", selectedImage: "mine_icon_select")
        
        let testVC = KKDemoViewController()
        let testNav = BaseNavigationViewController.init(rootViewController: testVC)
        testNav.tabBarItem.itemWithImage(title: "样例", image: "mine_icon_normal", selectedImage: "mine_icon_select")
        
        self.viewControllers = [homeNav,genealogyNav,traceNav,pofileNav,testNav]
    }
    
    func setItemAttribute() -> Void {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.kTABBAR_GRAY], for: UIControl.State.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.kNAVIGATION], for: UIControl.State.selected)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}


extension UITabBarController{
    override open var preferredStatusBarStyle: UIStatusBarStyle{
        if let ryVC = selectedViewController{
            return ryVC.preferredStatusBarStyle
        }
        return super.preferredStatusBarStyle
    }
    
    override open var shouldAutorotate: Bool {
        if let ryVC = selectedViewController{
            return ryVC.shouldAutorotate
        }
        return false
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let ryVC = selectedViewController{
            return ryVC.supportedInterfaceOrientations
        }
        return .portrait
    }
}
