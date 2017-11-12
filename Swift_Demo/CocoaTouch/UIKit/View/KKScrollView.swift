//
//  KKScrollView.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/11/12.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class KKScrollView: BaseView,KKPageControlDelegate,KKInfiniteScrollViewDelegate {
    lazy var scrollView : KKInfiniteScrollView = {
        let infinitFrame = CGRect.init(x: 0, y: kNAVIGATION_STATU_BAR_HEIGHT, width: kWINDOW_WIDTH, height: kFIT_INSTANCE.fitHeight(height: 256))
        let infinitScrollView = KKInfiniteScrollView.init(frame: infinitFrame, datas: ["image1","image3","image2"])
        infinitScrollView.scrollViewDelegate = self
        return infinitScrollView
    }()
    
    lazy var pageControl:KKPageControl = {
        let frame = CGRect.init(x: kMARGIN_HORIZONE, y: self.scrollView.frame.maxY - kFIT_INSTANCE.fitHeight(height: 30.0), width: kWINDOW_WIDTH - kMARGIN_HORIZONE*2, height: kFIT_INSTANCE.fitHeight(height: 30.0))
        let control = KKPageControl.init(frame: frame , count: 3, selectedType: KKPageControlType.LineWithCap, normalType: KKPageControlType.Dot,postionType:KKPageControlPosition.Center)
        control.delegate = self
        control.normalColor = kCOLOR_BUTTON_NORMOL
        control.selectedColor = kCOLOR_SAFELY
        return control
    }()
    
    init(frame: CGRect,needControl:Bool) {
        super.init(frame: frame)
        self.initPannel(needControl:needControl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPannel(needControl:Bool) -> Void {
        self.addSubview(scrollView)
        if needControl {
            self.addSubview(pageControl)
        }
    }
    
    //MARK:KKInfiniteScrollViewDelegate
    func clickAt(index: Int) {
        print("delegate clickAt index:",index)
    }
    
    //滚动scrollView,同时滚动pageControll
    func scrollAt(index: Int) {
        print("delegate scrollAt index:",index)
        self.pageControl.clickAt(object: self.pageControl)
    }
    
    //MARK:KKPageControlDelegate
    func clicked(control: KKPageControl) {
        print("pageControl did clicked:",control.current)
        self.scrollView.jumTo(page: control.current)
    }
    
    
    
}
