//
//  KKButton.swift
//  Swift_Demo
//
//  Created by Jerry on 2017/11/21.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class KKButton: UIButton,NVActivityIndicatorViewable {
    
    var dotAnimateButton : UIButton  {
        let view = UIButton.init()
        
        return view
    }
    
    var animatingView : NVActivityIndicatorView {
        let view =  NVActivityIndicatorView.init(frame: CGRect.zero, type: NVActivityIndicatorType.ballBeat, color: kCOLOR_WHITE, padding: 0.0)
        
        return view
    }
    
    
    
}
