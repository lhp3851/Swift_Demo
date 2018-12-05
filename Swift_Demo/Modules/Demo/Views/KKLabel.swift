//
//  KKLabel.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/29.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKLabel: UILabel {

    
    
    override var numberOfLines: Int {
        get {
            if super.numberOfLines == 1 {
                return 0
            }
            else{
                return super.numberOfLines
            }
        }
        set{
            if newValue != super.numberOfLines {
                super.numberOfLines = newValue
            }
        }
    }
    
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


extension KKLabel {
    
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
        }
    }
    
    func adjustFrame()  {//frame:CGRect,font:UIFont
        if let text = self.text {
            self.edgeInsets = UIEdgeInsetsMake(10, 10, 0, 5)
            self.numberOfLines = 0
            self.lineBreakMode = .byTruncatingTail
            let maxSize = CGSize.init(width: kWINDOW_WIDTH - 30, height: kWINDOW_HEIGHT - kNAVIGATION_STATU_BAR_HEIGHT - kTAB_BAR_HEIGHT - 30)
            let expectSize = self.sizeThatFits(maxSize)
            self.frame = CGRect.init(x: 15, y: 15, width: expectSize.width, height: expectSize.height)
        }
    }
    
}
