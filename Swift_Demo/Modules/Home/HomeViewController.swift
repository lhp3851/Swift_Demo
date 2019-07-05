//
//  HomeViewController.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/12.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SDCycleScrollView

class HomeViewController: BaseViewController,SDCycleScrollViewDelegate,CAAnimationDelegate {

    lazy var rotateAnimate: CABasicAnimation = {
        let rotateAnimate = CABasicAnimation.init()
        rotateAnimate.keyPath = "transform.rotation.y"
        rotateAnimate.duration = 1.0
        rotateAnimate.toValue = Float.pi
        rotateAnimate.repeatCount = 3
        rotateAnimate.isRemovedOnCompletion = false
        return rotateAnimate
    }()

    lazy var rotateZAnimate:  CABasicAnimation = {
        let rotateAnimate = CABasicAnimation.init()
        rotateAnimate.duration = 1.0
        rotateAnimate.toValue = 100
        rotateAnimate.repeatCount = 3
        rotateAnimate.isRemovedOnCompletion = false
        return rotateAnimate
    }()


    lazy var  groupAnimate:CAAnimationGroup =  {
        let groupAnimate = CAAnimationGroup.init()
        groupAnimate.beginTime = CFAbsoluteTimeGetCurrent() + 3
        groupAnimate.animations = [rotateAnimate,rotateZAnimate]
        groupAnimate.delegate = self
        groupAnimate.duration = 10
        return groupAnimate
    }()

    lazy var animateView:UIView = {
        let temp = UIView()
        let frame = CGRect.init(x: 0, y: 0, width: 120, height: 180)
        temp.frame = frame
        temp.center = self.view.center
        temp.backgroundColor = UIColor.red
        return temp
    }()

    lazy var activityView:NVActivityIndicatorView = {
        let view = ProgressHUDTool.activityView
        return view
    }()

    lazy var scrollView : SDCycleScrollView = {
        let infinitFrame = CGRect.init(x: 0, y: 0, width: UIScreen.width, height: 256.yfit)
        let view = SDCycleScrollView.init(frame: infinitFrame, imageNamesGroup: ["image1","image2","image3"])
        view?.autoScrollTimeInterval = 2.0
        view?.pageControlStyle = SDCycleScrollViewPageContolStyle.init(1)
        view?.delegate = self
        return view!
    }()

    lazy var infinitView : KKScrollView = {
        let infinitFrame = CGRect.init(x: 0, y: self.scrollView.frame.maxY + 20.0, width: UIScreen.width, height: 256.yfit)
        let view = KKScrollView.init(frame: infinitFrame, needControl: true)
        return view
    }()

    lazy var contetLabel:KKLabel = {
        let frame = CGRect.init(x: 15, y: 15 + kNAVIGATION_STATU_BAR_HEIGHT, width: UIScreen.width - 30, height: 30)
        let temp = KKLabel.init(frame: frame)
        temp.textAlignment = .left
        temp.backgroundColor = UIColor.kNOTTOUCH
        temp.numberOfLines = 0
        temp.lineBreakMode = NSLineBreakMode.byClipping
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        animateView.layer.add(groupAnimate, forKey: "group_animate")
        animateView.layer.add(rotateZAnimate, forKey: "rotate_animate")
    }

    override func initPannel() {
        super.initPannel()
        self.view.backgroundColor = UIColor.kBACKGROUND
        self.navigationItem.leftBarButtonItem = BarButtonItem().itemWithType(type: .BarButtomeTypePhone, title: "", selector: #selector(getContacts), target: self)
        self.navigationItem.rightBarButtonItem = BarButtonItem().itemWithType(type: .BarButtomeTypeQRCode, title: "", selector: #selector(scanQRcode), target: self)
        self.view.addSubview(contetLabel)
        self.view.addSubview(animateView)
    }


    override func initData() {
        super.initData()

        let chinese : String = "Swift 是一种新的编程语言，用于编写 iOS 和 OS X 应用。Swift 是一种新的编程语言，用于编写 iOS 和 OS X 应用。Swift 是一种新的编程语言，用于编写 iOS 和 OS X 应用。\n"
        let index =  chinese.firstIndex(of: "是")
        let result = chinese.reversed()
        print(chinese.startIndex,chinese.endIndex,chinese.count,"index:",index!,result)

        contetLabel.text = chinese
        contetLabel.adjustFrame()

        let tool = KKGenericsTool()
        tool.stackTest()
        tool.protocolTeslt()
    }

    @objc func getContacts() {
        let contactsVC = ContactsViewController()
        BaseViewController.jumpViewController(sourceViewConrroller: self, destinationViewController: contactsVC, animated: true)
    }

    
    @objc func scanQRcode(){
        let QRcodeVC = QRCodeViewController()
        BaseViewController.jumpViewController(sourceViewConrroller: self, destinationViewController: QRcodeVC, animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        print(index)
    }

    @objc func injected(){
         print("I've been injected: \(self)")
    }

    func animationDidStart(_ anim: CAAnimation) {
        print("animate start")
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animate stop")
    }

}
