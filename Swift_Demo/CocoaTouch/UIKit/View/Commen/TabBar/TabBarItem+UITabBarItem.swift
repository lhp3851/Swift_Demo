//
//  TabBarItem+UITabBarItem.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/14.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarItem {
     func itemWithImage(title:String,image:String,selectedImage:String) -> Void {
        self.title = title
        self.selectedImage = kIMAGE_WITH(name: selectedImage)
        self.image = kIMAGE_WITH(name: image)
        self.titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -3.0)
    }
}
