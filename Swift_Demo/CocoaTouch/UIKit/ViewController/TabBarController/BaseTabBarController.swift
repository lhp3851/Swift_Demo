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
    }

    func initPannle() -> Void {
        let homeVC = HomeViewController()
        let homeNav = BaseNavigationViewController.init(rootViewController: homeVC)
        homeNav.tabBarItem.title = "首页"
        homeNav.tabBarItem.image = UIImage.init(named: "Profile.png")
        homeNav.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -3.0)
        
        let genealogyVC = GenealogyViewController()
        let genealogyNav = BaseNavigationViewController.init(rootViewController: genealogyVC)
        genealogyNav.tabBarItem.title = "家谱"
        genealogyNav.tabBarItem.image = UIImage(named:"Profile")
        genealogyNav.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -3.0)
        
        let traceVC = TraceViewController()
        let traceNav = BaseNavigationViewController.init(rootViewController: traceVC)
        traceNav.tabBarItem.title = "事迹"
        traceNav.tabBarItem.image = UIImage(named:"Profile")
        traceNav.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -3.0)
        
        let pofileVC = ProfileViewController()
        let pofileNav = BaseNavigationViewController.init(rootViewController: pofileVC)
        pofileNav.tabBarItem.title = "我的"
        pofileNav.tabBarItem.image = UIImage(named:"Profile")
        pofileNav.tabBarItem.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -3.0)
        
        self.viewControllers = [homeNav,genealogyNav,traceNav,pofileNav]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
