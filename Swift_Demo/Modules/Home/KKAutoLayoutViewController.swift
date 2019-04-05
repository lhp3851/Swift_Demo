//
//  ViewController.swift
//  TMIJKDemo
//
//  Created by 纪志刚 on 2018/8/13.
//  Copyright © 2018年 纪志刚. All rights reserved.
//

import UIKit

class KKAutoLayoutViewController: BaseViewController {

    lazy var btn:UIButton = {
        let temp = UIButton.init(type: .custom)
        temp.backgroundColor = UIColor.red
        temp.setTitle("开始直播", for: .normal)
        temp.addTarget(self, action: #selector(start(_:)), for: .touchUpInside)
        temp.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(temp)
        return temp
    }()
    
    lazy var label:UILabel = {
        let temp = UILabel()
        temp.text = "文本标签🏷"
        temp.backgroundColor = UIColor.blue
        temp.textColor = UIColor.white
        temp.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(temp)
        return temp
    }()
    
    lazy var topConstraint:NSLayoutConstraint = {
        return NSLayoutConstraint.init(item: btn,
                                       attribute: NSLayoutAttribute.top,
                                       relatedBy: NSLayoutRelation.equal,
                                       toItem: view,
                                       attribute: NSLayoutAttribute.top,
                                       multiplier: 1,
                                       constant: 180)
    }()
    
    lazy var centerXContraint:NSLayoutConstraint = {
        return NSLayoutConstraint.init(item: btn,
                                       attribute: NSLayoutAttribute.centerX,
                                       relatedBy: NSLayoutRelation.equal,
                                       toItem: view,
                                       attribute: NSLayoutAttribute.centerX,
                                       multiplier: 1,
                                       constant: 1)
    }()
    
    lazy var leftConstraint:NSLayoutConstraint = {
        return NSLayoutConstraint.init(item: btn,
                                       attribute: NSLayoutAttribute.left,
                                       relatedBy: NSLayoutRelation.equal,
                                       toItem: view,
                                       attribute: NSLayoutAttribute.left,
                                       multiplier: 1, constant: 15)
    }()
    
    lazy var rightConstraint:NSLayoutConstraint = {
        return NSLayoutConstraint.init(item: btn,
                                       attribute: NSLayoutAttribute.right,
                                       relatedBy: NSLayoutRelation.equal,
                                       toItem: view,
                                       attribute: NSLayoutAttribute.right,
                                       multiplier: 1,
                                       constant: -15)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addLayOut()
        addLaoutVFL()
    }
    
    func addLayOut()  {
        btn.superview!.addConstraint(topConstraint)
        btn.superview!.addConstraint(leftConstraint)
        btn.superview!.addConstraint(rightConstraint)
    }
    
    func addLaoutVFL()  {
        let hMetrics = ["middleSpace": 10, "rightSpace": 20]
        let hViews = ["label": label, "btn": btn]
        let hVFL = "H:[label]-middleSpace-[btn]-rightSpace-|"
        let hConstraints:[NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: hVFL,
                                                          options: NSLayoutFormatOptions.directionLeadingToTrailing,
                                                          metrics: hMetrics,
                                                          views: hViews)
        
        let metrics = ["topSpace":120,"height":20]
        let viewes = ["label": label, "btn": btn]
        let vfls = "V:|-topSpace-[label]-[btn(height)]"
        let vConstraints:[NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: vfls,
                                                          options: NSLayoutFormatOptions(),
                                                          metrics: metrics,
                                                          views: viewes)
//        label.superview!.addConstraints(hConstraints + vConstraints)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal) //宽度不大于某个值
//        btn.setContentCompressionResistancePriority(.defaultLow, for: .vertical)//高度不小于某个值
        NSLayoutConstraint.activate(vConstraints + hConstraints)
    }
    
    func addLayoutAnchor()  {
        
    }
    
    func layoutUseStackView()  {
        
    }
    
    @objc private func start(_ btn:UIButton)
    {
        self.btn.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.25, delay: 8, options: .curveEaseInOut, animations: {
            self.topConstraint.constant = self.view.center.y
        }) { (status) in
            btn.updateConstraints()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

