//
//  KKPickerView.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

protocol KKPickerViewDataProtocol:NSObjectProtocol {
    
    func didSelect(model:Any)
    
}

protocol KKPickerViewProtocol:NSObjectProtocol {
    
    func subViewWith(cellForRowAt indexPath: IndexPath?,type:SelectorType) -> (UIView)
    
}


class KKPickerView: BaseView {

    weak var delegate:KKPickerViewProtocol?
    weak var dataSource:KKPickerViewDataProtocol?
    
    let rowHeight:CGFloat = 55
    
    var indexPath: IndexPath?
    
    var pickerType:SelectorType?
    
    var partNumber:Int = 0
    
    var title: String? {
        didSet{
            titleView.text = title
        }
    }
    
    var tap:UITapGestureRecognizer {
        let guesture = UITapGestureRecognizer.init(target: self, action: #selector(tapGuesture(tap:)))
        guesture.delegate = self
        return guesture
    }
    
    lazy var titleView:UILabel = {
        let temp = UILabel()
        temp.text = "选择器"
        temp.textColor = kCOLOR_TEXT_FIRST
        temp.font = kFONT_15
        temp.textAlignment = .center
        temp.backgroundColor = kCOLOR_WHITE
        temp.isUserInteractionEnabled = true
        temp.addGestureRecognizer(self.tap)
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
        temp.addGestureRecognizer(self.tap)
        return temp
    }()
    
    var currentModel:Any!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
    
    init(frame: CGRect,type:SelectorType,delegate:KKPickerViewProtocol?,dataSource:KKPickerViewDataProtocol?) {
        super.init(frame: frame)
        self.delegate = delegate
        self.dataSource = dataSource
        self.pickerType = type
        setUpPannel()
        initDatas(type: type)
    }
    
    func initDatas(type:SelectorType){
        let modelTitle = getTitle(type: type)
        title = modelTitle
    }
    
    func getTitle(type:SelectorType) -> String {
        var modelTitle = ""
        switch type {
        case .education:
            modelTitle = "教育程度"
        case .address:
            modelTitle = "地区"
        case .date:
            modelTitle = "出生日期"
        case .time:
            modelTitle = "时间"
        case .dateAndTime:
            modelTitle = "日期-时间"
        case .weight:
            modelTitle = "体重"
        case .stature:
            modelTitle = "身高"
        case .skt:
            modelTitle = "单位"
        default:
            modelTitle = "请选择"
        }
        return modelTitle
    }
    
    func getSelectedDatas(type:SelectorType) {
        switch type {
        case .education:
            currentModel = "教育程度"
        case .address:
            currentModel = "地区"
        case .date:
            currentModel = "出生日期"
        case .time:
            currentModel = "时间"
        case .dateAndTime:
            currentModel = "日期-时间"
        case .weight:
            currentModel = "体重"
        case .stature:
            currentModel = "身高"
        case .skt:
            currentModel = ""
        default:
            currentModel = "请选择"
        }
    }
    
    func setUpPannel(){
        self.isUserInteractionEnabled = true
        self.backgroundColor = kCOLOR_BACKGROUND_COLOR
        self.tintColor = KCOLOR_TINT_COLOR
        addSubview(titleView)
        addSubview(selectorBackView)
        addSubview(sendButton)
        setUpConstraints()
    }
    
    func setSubViewes() {
        if let subDelegate = self.delegate {
            let temp = subDelegate.subViewWith(cellForRowAt: self.indexPath,type: pickerType!)
            selectorBackView.addSubview(temp)
            temp.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
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
    
    @objc func sendDatas(sender:UIButton)  {
        if let senderDelegate = self.dataSource {
            getSelectedDatas(type: pickerType!)
            senderDelegate.didSelect(model: currentModel)
        }
    }
    
    @objc func tapGuesture(tap:UITapGestureRecognizer){
        print(tap)
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        let hitView = super.hitTest(point, with: event)
//        let convertPoint = self.convert(point, to: self)
//        if self.titleView.point(inside: convertPoint, with: event) {
//            return self.titleView
//        }
//        else if self.selectorBackView.point(inside: convertPoint, with: event) {
//            return self.selectorBackView
//        }
//        else if self.sendButton.point(inside: convertPoint, with: event){
//            return self.sendButton
//        }
//        else{
//            return hitView
//        }
//    }
}

extension KKPickerView: UIGestureRecognizerDelegate {
    
}
