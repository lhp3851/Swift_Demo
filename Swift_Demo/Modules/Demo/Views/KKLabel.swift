//
//  KKLabel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/29.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKLabel: UILabel {
    
    var edgeInsets: UIEdgeInsets? = UIEdgeInsetsMake(10, 10, -10, 10)
   
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
    
    func textWithWidth(width:CGFloat) {
        if let text = self.text,!text.isEmpty {
            let textWidth = text.width(withConstraniedHeight: .greatestFiniteMagnitude, font: self.font)
            let count = text.count
            let length = count - 1
            let margin = fabs((width - textWidth))/CGFloat(length)
            let attrs = [NSAttributedStringKey.font:self.font,
                         NSAttributedStringKey.kern:margin] as [NSAttributedStringKey : Any]
            let attrText = NSMutableAttributedString.init(string: text, attributes: attrs)
            self.attributedText = attrText
            self.sizeToFit()
        }
    }
    
    func adjustFrame()  {
        if let _ = self.text {
            self.numberOfLines = 0
            self.lineBreakMode = .byTruncatingTail
            self.sizeToFit()
        }
    }
}

