//
//  KKPageControl.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/11/8.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

enum KKPageControlType {
    case Dot
    case Line
    case LineWithCap
    case Default
}

enum KKPageControlPosition {
    case Left
    case Center
    case Right
}

let normalWidth : CGFloat = 8.0
let selectedWidth : CGFloat = 18.0
let selectedHeight : CGFloat = 3.0
let gap : CGFloat = 5.0

protocol KKPageControlDelegate {
    
    func clicked(control:KKPageControl) -> Void
    
}

class KKPageControl: UIPageControl {

    var delegate : KKPageControlDelegate?
    
    var normalType = KKPageControlType.Dot
    var selectedType = KKPageControlType.LineWithCap
    var selectedColor = kCOLOR_WHITE
    var normalColor = kCOLOR_BUTTON_NORMOL
    var count = 0
    var current = 0
    var position = KKPageControlPosition.Left
    
    private var margin = kMARGIN_HORIZONE
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect,type:KKPageControlType) {
        super.init(frame: frame)
        self.contentMode = UIViewContentMode.redraw
        self.normalType = type
        self.setUpPannel()
    }
    
    convenience init(frame: CGRect,count:Int,selectedType:KKPageControlType,normalType:KKPageControlType,postionType:KKPageControlPosition) {
        self.init(frame: frame, type: normalType)
        self.count = count
        self.selectedType = selectedType
        self.position = postionType
        print(self.frame)
        if self.position == KKPageControlPosition.Left {
            self.margin = kMARGIN_HORIZONE
        }
        else if self.position == KKPageControlPosition.Center {
            self.margin = (self.frame.width - CGFloat.init((count - 1))*(normalWidth + gap) - selectedWidth)/2 - kMARGIN_HORIZONE
        }
        else{
            self.margin = self.frame.width - CGFloat.init((count - 1))*(normalWidth + gap) - selectedWidth - kMARGIN_HORIZONE*2
        }
    }
    
    func setUpPannel() -> Void {
        self.backgroundColor = kCOLOR_WHITE
        self.addTarget(self, action: #selector(click(object:)), for: UIControlEvents.valueChanged)
    }
    
    func loadDatas() -> Void {
        
    }
    
    @objc private func click(object:KKPageControl) -> Void {
        print(object.current)
        if object.current < self.count - 1 {
            object.current += 1
        }
        else{
            object.current = 0
        }
        self.setNeedsDisplay()
        guard let delegate = self.delegate else { return }
        delegate.clicked(control: object)
    }
    
    //设计给外部调用的
    func clickAt(object:KKPageControl) -> Void {
        if object.current < self.count - 1 {
            object.current += 1
        }
        else{
            object.current = 0
        }
        self.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       let point = touches.first?.location(in: self)
        print(point!)
        if (point?.x)! < self.margin + CGFloat(self.current) * selectedWidth {
            if self.current > 0 {
                self.current -= 1
            }
            else{
                self.current = self.count - 1
            }
        }
        else{
            if self.current < self.count - 1 {
                self.current += 1
            }
            else{
                self.current = 0
            }
        }
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        print("type:",self.normalType,self.selectedType)
        switch self.selectedType {
        case .Dot:
            let subFrame =  CGRect.init(x: (self.frame.width - normalWidth)/2, y: (self.frame.height - normalWidth)/2, width: normalWidth, height: normalWidth)
            let path = UIBezierPath.init(ovalIn:subFrame)
            kCOLOR_BUTTON_NORMOL.setFill()
            path.fill()
            
        case .Line:
            let subFrame =  CGRect.init(x: (self.frame.width - selectedWidth)/2, y: (self.frame.height - selectedHeight)/2, width: selectedWidth, height: selectedHeight)
            let path = UIBezierPath.init(rect: subFrame)
            kCOLOR_BUTTON_NORMOL.setFill()
            path.fill()
        
        case .LineWithCap:
            for i in 0..<self.count {
                if i == self.current {
                    let subFrame =  CGRect.init(x: self.margin + CGFloat(i) * selectedWidth , y: (self.frame.height - selectedHeight)/2, width: selectedWidth, height: selectedHeight)
                    let path = UIBezierPath.init(roundedRect: subFrame, cornerRadius: 4)
                    self.selectedColor.setFill()
                    path.fill()
                }
                else{
                    var subFrame =  CGRect.init(x: self.margin + CGFloat(i) * selectedWidth, y: (self.frame.height - normalWidth)/2, width: normalWidth, height: normalWidth)
                    if i > self.current  {
                        subFrame.origin.x += (selectedWidth - normalWidth)
                    }
                    let path = UIBezierPath.init(ovalIn:subFrame)
                    self.normalColor.setFill()
                    path.fill()
                }
            }
            
        default:
            let subFrame =  CGRect.init(x: (self.frame.width - normalWidth)/2, y: (self.frame.height - normalWidth)/2, width: normalWidth, height: normalWidth)
            let path = UIBezierPath.init(ovalIn:subFrame)
            kCOLOR_BUTTON_NORMOL.setFill()
            path.fill()
        }
        
    }
 
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("true")
        return true
    }

}
