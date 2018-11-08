//
//  KKInfiniteScrollView.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/11/12.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

protocol KKInfiniteScrollViewDelegate {
    func clickAt(index:Int) -> Void //点击
    
    func scrollAt(index:Int) -> Void //滚动到
    
}

class KKInfiniteScrollView: UIScrollView,UIScrollViewDelegate {
    let viewWidth = kWINDOW_WIDTH
    let viewHeight = kFIT_INSTANCE.fitHeight(height: 256.0)
    
    private(set) var currentPage = 0 //当前页数
    
    var datasArray:[String] = [String]()//存放图片的名字
    
    var isScrolling = true//是否正在滚动
    var scrollViewDelegate : KKInfiniteScrollViewDelegate?
    
    var interval = 1.0 //定时器触发间隔
    var timeLine = 10.0
    
    
    lazy var timer : DispatchSourceTimer = {
        let timeTool = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timeTool.schedule(deadline: DispatchTime.now(), repeating: self.interval)
        return timeTool
    }()

    
    init(frame: CGRect,datas:[String]) {
        super.init(frame: frame)
        self.isPagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.delegate = self
        self.initDatas(datas: datas)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initDatas(datas:[String]) -> Void {
        self.interval = 1
        self.isScrolling = true
        
        self.datasArray = datas
        self.datasArray.append(datas.last!)
        self.datasArray.insert(datas.first!, at: 0)
        
        for (idx,imageName) in self.datasArray.enumerated() {
            let frame = CGRect.init(x: CGFloat(idx)*viewWidth, y: 0, width: viewWidth, height: viewHeight)
            print("frame.origin.x:",frame.origin.x,viewWidth)
            let imageView = KKImageView.init(frame: frame, action: { (imageView) in
                print("clicked imageView")
            })
            imageView.image = kIMAGE_WITH(name: imageName)
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = UIViewContentMode.redraw
            self.addSubview(imageView)
        }

        self.contentSize = CGSize.init(width: CGFloat(self.datasArray.count)*viewWidth, height: 0)
        self.contentOffset = CGPoint.init(x: viewWidth, y: 0)
        self.startAutoScroll()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.makeInfiniteScrolling()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.makeInfiniteScrolling()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.stopScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.startAutoScroll()
    }
    
    func startAutoScroll() -> Void {
        if self.interval == 0 {
            return
        }
        
        self.isScrolling = true
        print("start")
        self.timer.setEventHandler {
            self.timeLine -= self.interval
            if self.timeLine < 0{
                self.timer.cancel()
            }
            DispatchQueue.main.async(execute: {
                let offset :CGFloat = self.contentOffset.x + self.viewWidth;
                self.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
            })
        }
        self.timer.resume()
    }
    
    func makeInfiniteScrolling() -> Void {
        let page : Int = Int(self.contentOffset.x / viewWidth)
        if page == self.datasArray.count - 1 {
            self.currentPage = 0
            self.setContentOffset(CGPoint.init(x: viewWidth, y: 0), animated: false)
        }
        else if page == 0 {
            self.currentPage = page - 2
            self.setContentOffset(CGPoint.init(x: CGFloat((self.datasArray.count - 2))*viewWidth, y: 0), animated: false)
        }
        else{
            self.currentPage = page - 1
        }
        guard let delegateLocal = self.scrollViewDelegate else { return }
        delegateLocal.scrollAt(index: self.currentPage)
    }
    
    func stopScroll() -> Void {
        print("stop")
        self.isScrolling = false
        self.timer.suspend()
    }
    
    //调到指定页面去
    func jumTo(page:Int) -> Void {
        if page>self.datasArray.count || page < 0 {
            return
        }
        self.setContentOffset(CGPoint.init(x: CGFloat(page+1)*viewWidth, y: 0), animated: false)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
