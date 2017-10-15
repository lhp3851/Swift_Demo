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
        let image = kIMAGE_WITH(name: "navigation_bar")
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
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
