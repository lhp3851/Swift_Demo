//
//  BaseNavigationViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/13.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        let target = interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        pan.delegate = self;
        view.addGestureRecognizer(pan)
        interactivePopGestureRecognizer?.isEnabled = false
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
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animatedVC = KKAnimateViewController()
        animatedVC.operation = operation
        return animatedVC
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if childViewControllers.count == 0 {
            return false
        }
        return true
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
