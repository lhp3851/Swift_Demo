//
//  KKButtonViewController.swift
//  Swift_Demo
//
//  Created by Jerry on 2017/11/21.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class KKButtonViewController: BaseViewController {

    var vcTitle = NSStringFromClass(KKButtonViewController.self)
    
    lazy var animatingView : NVActivityIndicatorView = {
        let frame = CGRect.init(x:kNAVIGATION_STATU_BAR_HEIGHT, y: kNAVIGATION_STATU_BAR_HEIGHT, width: UIScreen.width - kNAVIGATION_STATU_BAR_HEIGHT*2, height: 44.0)
        let view =  NVActivityIndicatorView.init(frame: frame, type: NVActivityIndicatorType.ballBeat, color: UIColor.kWHITE, padding: 0.0)
        view.backgroundColor = UIColor.kWARNING
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initData() {
        super.initData()
        self.navigationItem.title = self.vcTitle
    }
    
    override func initPannel() {
        super.initPannel()
        self.view.addSubview(self.animatingView)
        self.setConstraints()
        self.animatingView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8)) {
            self.animatingView.stopAnimating()
        }
    }
    
    func setConstraints() -> Void {
        self.animatingView.snp.makeConstraints { (make) in
            make.top.left.equalTo(kNAVIGATION_STATU_BAR_HEIGHT)
            make.right.equalTo(-kNAVIGATION_STATU_BAR_HEIGHT)
            make.height.equalTo(44.yfit)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeLeft
    }
    
    
    func setOrientation(orientation:UIDeviceOrientation)  {
        let ori = NSNumber.init(value: 4)
        UIDevice.current.setValue(ori, forKey: "orientation")
    }
    
}
