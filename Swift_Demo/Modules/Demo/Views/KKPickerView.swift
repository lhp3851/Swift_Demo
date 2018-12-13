//
//  KKPickerView.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

protocol KKPickerViewProtocol:NSObjectProtocol {
    
    func subViewWith(cellForRowAt indexPath: IndexPath?,type:SelectorType) -> (UIView)
    
    func didSelect(model:Any,type:SelectorType)
    
}


class KKPickerView: BaseView {

    weak var delegate:KKPickerViewProtocol?
    
    let rowHeight:CGFloat = 55
    var model:Any!
    
    var indexPath: IndexPath?
    
    var pickerType:SelectorType?
    
    var partNumber:Int = 1
    
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
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let temp = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        temp.delegate = self
        temp.dataSource = self
        return temp
    }()
    
    lazy var horizoneLineTop: UIView = {
        let temp = UIView()
        temp.backgroundColor = KCOLOR_SEPERATE_LINE
        return temp
    }()
    
    lazy var horizoneLineBottom: UIView = {
        let temp = UIView()
        temp.backgroundColor = KCOLOR_SEPERATE_LINE
        return temp
    }()
    
    var currentModel:Any!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
    
    init(frame: CGRect,type:SelectorType,delegate:KKPickerViewProtocol?) {
        super.init(frame: frame)
        self.delegate = delegate
        self.pickerType = type
        setUpPannel()
        initDatas(type: type)
    }
    
    func initDatas(type:SelectorType){
        title = "选择器"
    }
    
    func setUpPannel(){
        self.isUserInteractionEnabled = true
        self.backgroundColor = kCOLOR_BACKGROUND_COLOR
        self.tintColor = KCOLOR_TINT_COLOR
        addSubview(titleView)
        selectorBackView.addSubview(collectionView)
        registeCell(type: self.pickerType ?? .education)
        addSubview(selectorBackView)
        addSubview(horizoneLineTop)
        addSubview(horizoneLineBottom)
        addSubview(sendButton)
        setUpConstraints()
        addBlureTheEdges()
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
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        titleView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(rowHeight)
        }
        
        selectorBackView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.bottom.equalTo(sendButton.snp.top).offset(-10)
        }
        
        horizoneLineTop.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1.0)
            make.top.equalTo(120)
        }
        
        horizoneLineBottom.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(1.0)
            make.top.equalTo(horizoneLineTop.snp.bottom).offset(54)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.top.equalTo(selectorBackView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(rowHeight)
            make.bottom.equalToSuperview()
        }
    }
    
    func addBlureTheEdges() {
        let frame = CGRect.init(x: 0, y: 120, width: kWINDOW_WIDTH, height: 56)
        let fullFrame = CGRect.init(x: 0, y: 65, width: kWINDOW_WIDTH, height: 167)
        let path = UIBezierPath.init(rect: fullFrame)
        let reservePath = UIBezierPath.init(roundedRect: frame, cornerRadius: 5.0)
        path.append(reservePath)
        path.usesEvenOddFillRule = true
        
        let layer = CAShapeLayer.init(layer: collectionView.layer)
        layer.path = path.cgPath
        layer.fillColor = kCOLOR_WHITE.cgColor
        layer.opacity = 0.7
        layer.fillRule = kCAFillRuleEvenOdd
        self.layer.addSublayer(layer)
    }
    
    func registeCell(type:SelectorType)  {
        switch type {
        case .education:
            partNumber = 1
            collectionView.register(KKEducationPickerView.self, forCellWithReuseIdentifier: pickerType?.rawValue ?? "education")
        case .gender:
            partNumber = 1
            collectionView.register(KKGenderPickerView.self, forCellWithReuseIdentifier: pickerType?.rawValue ?? "gender")
        case .address:
            partNumber = 3
            collectionView.register(KKAddressPickerView.self, forCellWithReuseIdentifier: pickerType?.rawValue ?? "address")
        case .time:
            partNumber = 3
            collectionView.register(KKTimePickerView.self, forCellWithReuseIdentifier: pickerType?.rawValue ?? "time")
        case .date:
            partNumber = 3
            collectionView.register(KKDatePickerView.self, forCellWithReuseIdentifier: pickerType?.rawValue ?? "date")
        case .dateAndTime:
            partNumber = 3
            collectionView.register(KKDateTimePickerView.self, forCellWithReuseIdentifier: pickerType?.rawValue ?? "dateAndTime")
        case .weight:
            partNumber = 2
            collectionView.register(KKWeightPickerView.self, forCellWithReuseIdentifier: pickerType?.rawValue ?? "weight")
        case .stature:
            partNumber = 1
            collectionView.register(KKStaturePickerView.self, forCellWithReuseIdentifier: pickerType?.rawValue ?? "stature")
        case .skt:
            partNumber = 1
            collectionView.register(KKSKTPickerView.self, forCellWithReuseIdentifier: pickerType?.rawValue ?? "skt")
        case .threeColumn:
            partNumber = 3
            collectionView.register(KKDateTimePickerView.self, forCellWithReuseIdentifier: pickerType?.rawValue ?? "threeColumn")
        default:
            partNumber = 1
            collectionView.register(KKEducationPickerView.self, forCellWithReuseIdentifier: pickerType?.rawValue ?? "other")
        }
    }
    
    // MARK:  选择数据
    @objc func sendDatas(sender:UIButton)  {
       
    }
    
    @objc func tapGuesture(tap:UITapGestureRecognizer){
        print(tap)
    }
    
}


extension KKPickerView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return partNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifiler = pickerType?.rawValue ?? "education"
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifiler, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width / CGFloat(partNumber), height: self.frame.height - 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}














































extension KKPickerView: UIGestureRecognizerDelegate {
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
