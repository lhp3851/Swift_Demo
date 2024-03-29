//
//  KKPickerView.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

protocol KKPickerViewProtocol:NSObjectProtocol {
            
    func didSelect(model:Any,type:SelectorType)
    
}


class KKPickerView: BaseView,UIGestureRecognizerDelegate {

    weak var delegate:KKPickerViewProtocol?
    
    let rowHeight:CGFloat = 55
    
    var model:KKPickerViewDataSource!
    
    var indexPath: IndexPath?
    
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
        temp.textColor = UIColor.kTEXT_FIRST
        temp.font = UIFont.F15
        temp.textAlignment = .center
        temp.backgroundColor = UIColor.kWHITE
        temp.isUserInteractionEnabled = true
        temp.addGestureRecognizer(self.tap)
        return temp
    }()
    
    lazy var sendButton:UIButton = {
        let temp = UIButton()
        temp.setTitle("确定", for: .normal)
        temp.titleLabel?.font = UIFont.F15
        temp.setTitleColor(UIColor.kBUTTON_NORMOL, for: .normal)
        temp.backgroundColor = UIColor.kWHITE
        temp.addTarget(self, action: #selector(sendDatas(sender:)), for: .touchUpInside)
        return temp
    }()
    
    lazy var selectorBackView: UIView = {
        let temp = UIView()
        temp.isUserInteractionEnabled = true
        temp.backgroundColor = UIColor.kWHITE
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
        temp.register(KKCollectionFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: KKCollectionFooterReusableView.identifier)
        temp.backgroundColor = UIColor.white
        return temp
    }()
    
    lazy var horizoneLineTop: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.kSEPERATE_LINE
        return temp
    }()
    
    lazy var horizoneLineBottom: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.kSEPERATE_LINE
        return temp
    }()
    
    var currentModel:Any!
    
    var selectModel:[[String]] = [[""],[""],[""]]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
    
    init(frame: CGRect,model:KKPickerViewDataSource,delegate:KKPickerViewProtocol?) {
        super.init(frame: frame)
        self.delegate = delegate
        self.model = model
        setUpPannel()
        initDatas(model: model)
    }
    
    func initDatas(model:KKPickerViewDataSource){
        title = model.title
    }
    
    func setUpPannel(){
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.kBACKGROUND_COLOR
        self.tintColor = UIColor.kTINT_COLOR
        addSubview(titleView)
        selectorBackView.addSubview(collectionView)
//        registeCell(type: self.model.type ?? .education)
        addSubview(selectorBackView)
        addSubview(horizoneLineTop)
        addSubview(horizoneLineBottom)
        addSubview(sendButton)
        setUpConstraints()
        addBlureTheEdges()
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
        let frame = CGRect.init(x: 0, y: 120, width: UIScreen.width, height: 56)
        let fullFrame = CGRect.init(x: 0, y: 65, width: UIScreen.width, height: 167)
        let path = UIBezierPath.init(rect: fullFrame)
        let reservePath = UIBezierPath.init(roundedRect: frame, cornerRadius: 5.0)
        path.append(reservePath)
        path.usesEvenOddFillRule = true
        
        let layer = CAShapeLayer.init(layer: collectionView.layer)
        layer.path = path.cgPath
        layer.fillColor = UIColor.kWHITE.cgColor
        layer.opacity = 0.7
        layer.fillRule = CAShapeLayerFillRule.evenOdd
        self.layer.addSublayer(layer)
    }
    
    func registeCell(type:SelectorType)  {
        switch type {
        case .education:
            collectionView.register(KKEducationPickerView.self, forCellWithReuseIdentifier: type.rawValue )
        case .gender:
            collectionView.register(KKGenderPickerView.self, forCellWithReuseIdentifier: type.rawValue)
        case .address:
            collectionView.register(KKAddressPickerView.self, forCellWithReuseIdentifier: type.rawValue)
        case .time:
            collectionView.register(KKTimePickerView.self, forCellWithReuseIdentifier: type.rawValue )
        case .date:
            collectionView.register(KKDatePickerView.self, forCellWithReuseIdentifier: type.rawValue)
        case .dateAndTime:
            collectionView.register(KKDateTimePickerView.self, forCellWithReuseIdentifier: type.rawValue)
        case .weight:
            collectionView.register(KKWeightPickerView.self, forCellWithReuseIdentifier: type.rawValue)
        case .stature:
            collectionView.register(KKStaturePickerView.self, forCellWithReuseIdentifier: type.rawValue)
        case .skt:
            collectionView.register(KKSKTPickerView.self, forCellWithReuseIdentifier: type.rawValue)
        case .threeColumn:
            collectionView.register(KKDateTimePickerView.self, forCellWithReuseIdentifier: type.rawValue)
        default:
            collectionView.register(KKEducationPickerView.self, forCellWithReuseIdentifier: type.rawValue)
        }
    }
    
    // MARK:  选择数据
    @objc func sendDatas(sender:UIButton)  {
//       getSelectDetail(model: model)
    }
    
    @objc func tapGuesture(tap:UITapGestureRecognizer){
        print(tap)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        let convertPoint = self.convert(point, to: self)
        if self.titleView.point(inside: convertPoint, with: event) {
            return self.titleView
        }
        else if self.selectorBackView.point(inside: convertPoint, with: event) {
            return self.selectorBackView
        }
        else if self.sendButton.point(inside: convertPoint, with: event){
            return self.sendButton
        }
        else{
            return hitView
        }
    }
    
}


extension KKPickerView: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:KKPickerSubView = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! KKPickerSubView
//        cell.indexPath = indexPath
//        cell.delegate = self
//        cell.model = self.model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.zero
//        return CGSize.init(width: UIScreen.main.bounds.width / CGFloat(self.model.datas?.count ?? 1), height: self.frame.height - 130)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
       
//        if let currentModel = self.model,currentModel.type == SelectorType.time {
//            return CGSize.init(width: 7.5, height: 55.5)
//        }
//        else{
            return CGSize.zero
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView :UICollectionReusableView?
        
        if kind == UICollectionView.elementKindSectionFooter {
            
            let footer :KKCollectionFooterReusableView = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionView.elementKindSectionFooter, withReuseIdentifier: KKCollectionFooterReusableView.identifier, for: indexPath) as! KKCollectionFooterReusableView

            reusableView = footer
            
        } else if  kind == UICollectionView.elementKindSectionHeader {
            
            let header  = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath)
            
            reusableView = header
        }
        
        return reusableView!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}


extension KKPickerView:KKPickerDataProtocol{
    
    func pickDatas(model: KKPickerModel) {
//        self.model = model
//        updateSubLayerDatas(model: self.model)
    }
    
//    func getSelectDetail(model:KKPickerViewDataSource)  {
//        let index = model.selectIndex
//        let datas:[[String]] = model.datas as! [[String]]
//        let selectItem = datas[index.section][index.row]
//        selectModel[index.section] = [selectItem]
//        print(selectModel)
//    }
    
    func updateSubLayerDatas(model:KKPickerModel) {
        if let type:SelectorType = model.type {
            if type == .address && model.selectIndex.section == 0 {
                let currentModel:KKAddressPickerModel = model as! KKAddressPickerModel
                var datas:[[String]] = currentModel.datas as! [[String]]
                let province = currentModel.provinces[model.selectIndex.row]
                let cities = currentModel.getCities(province: province)
                let city = cities[1]
                let areas = currentModel.getArea(city: city, province: province)
                datas.remove(at: 2)//移除区域
                datas.remove(at: 1)//移除城市
                datas.append(cities)
                datas.append(areas)
                currentModel.datas = datas
                collectionView.reloadData()
                print("联动数据")
            }
        }
    }
}












































