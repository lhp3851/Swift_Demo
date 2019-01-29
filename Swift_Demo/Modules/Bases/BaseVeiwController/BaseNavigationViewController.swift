//
//  BaseNavigationViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/13.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavigationBar()
    }

    func initNavigationBar() -> Void {
        var image = kIMAGE_WITH(name: "navigation_bar", needOften: false)
        image = image.withRenderingMode(.alwaysTemplate)
        UINavigationBar.appearance().setBackgroundImage(image, for: UIBarMetrics.default)
        UINavigationBar.appearance().barStyle = UIBarStyle.black
        UINavigationBar.appearance().tintColor = kCOLOR_BUTTON_NORMOL
        UINavigationBar.appearance().barTintColor = kCOLOR_CLEAR
        UINavigationBar.appearance().titleTextAttributes =  {[NSAttributedStringKey.foregroundColor:kCOLOR_WHITE,NSAttributedStringKey.font:kFONT_18]}()
        UINavigationBar.appearance().backIndicatorImage = UIImage.imageWithColor(color: kCOLOR_CLEAR)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage.imageWithColor(color: kCOLOR_CLEAR)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension UINavigationController{
    override open var shouldAutorotate: Bool {
        if let ryVC = viewControllers.last{
            return ryVC.shouldAutorotate
        }
        return false
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let ryVC = viewControllers.last{
            return ryVC.supportedInterfaceOrientations
        }
        return .portrait
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle{
        if let ryVC = viewControllers.last{
            return ryVC.preferredStatusBarStyle
        }
        return super.preferredStatusBarStyle
    }
}
