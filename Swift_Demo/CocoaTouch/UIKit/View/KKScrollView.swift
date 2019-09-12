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
        let infinitFrame = CGRect.init(x: 0, y: BaseViewController().kSTATU_BAR_HEIGHT, width: UIScreen.width, height: 256.yfit)
        let infinitScrollView = KKInfiniteScrollView.init(frame: infinitFrame, datas: ["image1","image3","image2"])
        infinitScrollView.scrollViewDelegate = self
        return infinitScrollView
    }()
    
    lazy var pageControl:KKPageControl = {
        let frame = CGRect.init(x: UIScreen.hMargin, y: self.scrollView.frame.maxY - 30.yfit, width: UIScreen.width - UIScreen.hMargin*2, height: 30.yfit)
        let control = KKPageControl.init(frame: frame , count: 3, selectedType: KKPageControlType.LineWithCap, normalType: KKPageControlType.Dot,postionType:KKPageControlPosition.Center)
        control.delegate = self
        control.normalColor = UIColor.kBUTTON_NORMOL
        control.selectedColor = UIColor.kSAFELY
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
