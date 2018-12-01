//
//  KKPickerView.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

protocol KKPickerViewProtocol:NSObjectProtocol {
    
    func pickerView(view:UIView) -> (UIView & KKPickerViewProtocol)
    
}

protocol KKPickerViewDataSource:NSObjectProtocol {
    
    func pickDatas(model:Any)
    
}

class KKPickerView: BaseView {

    weak var delegate:KKPickerViewProtocol?
    let rowHeight:CGFloat = 55
    var model:Any!
    
    lazy var titleView:UILabel = {
        let temp = UILabel()
        temp.text = "选择器"
        temp.textColor = kCOLOR_TEXT_FIRST
        temp.font = kFONT_15
        temp.textAlignment = .center
        temp.backgroundColor = kCOLOR_WHITE
        temp.isUserInteractionEnabled = true
        return temp
    }()
    
    lazy var sendButton:UIButton = {
        let temp = UIButton()
        temp.setTitle("确定", for: .normal)
        temp.titleLabel?.font = kFONT_15
        temp.setTitleColor(kCOLOR_BUTTON_NORMOL, for: .normal)
        temp.backgroundColor = kCOLOR_WHITE
        temp.addTarget(self, action: #selector(sendDatas(sender:)), for: .touchUpInside)
        return temp
    }()
    
    lazy var selectorBackView: UIView = {
        let temp = UIView()
        temp.isUserInteractionEnabled = true
        temp.backgroundColor = kCOLOR_WHITE
        return temp
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
    
    init(frame: CGRect,title:String,datas:Any) {
        super.init(frame: frame)
        setUpPannel()
        initDatas(title: title,datas: datas)
    }
    
    func initDatas(title:String,datas:Any){
        titleView.text = title
        self.model = datas
    }
    
    func setUpPannel(){
        self.isUserInteractionEnabled = true
        self.backgroundColor = kCOLOR_BACKGROUND_COLOR
        addSubview(titleView)
        addSubview(selectorBackView)
        addSubview(sendButton)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        titleView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(rowHeight)
        }
        
        selectorBackView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.bottom.equalTo(sendButton.snp.top).offset(-10)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.top.equalTo(selectorBackView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(rowHeight)
            make.bottom.equalToSuperview()
        }
    }
    
    func getSubView(model:Any) -> (UIView.Type & KKPickerViewProtocol.Type)? {
        if let sender = self.delegate {
            let tempView = sender.pickerView(view: <#T##UIView#>)
            return tempView
        }
        return nil
    }
    
    @objc func sendDatas(sender:UIButton)  {
        if let senderDelegate = self.delegate {
            print(sender)
            senderDelegate.pickDatas(model: model)
        }
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        let point = self.convert(point, to: self)
        if self.titleView.point(inside: point, with: event) {
            return self.titleView
        }
        else if self.selectorBackView.point(inside: point, with: event) {
            return self.selectorBackView
        }
        else if self.sendButton.point(inside: point, with: event){
            return self.sendButton
        }
        else{
            return view
        }
    }
}
