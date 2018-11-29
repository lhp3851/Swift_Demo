//
//  KKLabel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/29.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKLabel: UILabel {

    var edgeInsets: UIEdgeInsets? = UIEdgeInsets.zero
   
    override func draw(_ rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, self.edgeInsets!))
    }

    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        if let inset = self.edgeInsets {
            var frame = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, inset), limitedToNumberOfLines: numberOfLines)
            frame.origin.x -= inset.left
            frame.origin.y -= inset.top
            frame.size.width += (inset.left + inset.right)
            frame.size.height += (inset.top + inset.bottom)
            return frame
        }
        else{
            return self.frame
        }
    }

}
