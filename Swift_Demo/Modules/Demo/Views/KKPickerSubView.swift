//
//  KKPickerSubView.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/26.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

protocol KKPickerDataProtocol:NSObjectProtocol {
    
    func pickDatas(model:KKPickerModel)
    
}

class KKPickerSubView: UICollectionViewCell,KKPickerDataProtocol {

    var indexPath:IndexPath? = IndexPath.init(row: 1, section: 0) {
        didSet{
            if let currentModel = self.model {
                currentModel.selectIndex = indexPath!
            }
        }
    }
    
    weak var delegate:KKPickerDataProtocol?
    
    private let pickerViewHeight:CGFloat = 297
    
    var model:KKPickerModel? {
        didSet{
            if let currentModel = model,currentModel.needUnit {
                addUnitsLable()
            }
        }
    }
    
    override func didMoveToSuperview() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            self.updateCurrentIndex(index: 1)
            self.pickDatas(model: self.model!)
        }
    }
    
    var datas: [[String]]! {
        return self.model!.datas as? [[String]]
    }
    
    lazy var unitLabel:UILabel = {
        let temp = UILabel()
        temp.text = model?.unit
        temp.textColor = KCOLOR_TINT_COLOR
        temp.font = kFONT_15
        temp.textAlignment = .left
        temp.backgroundColor = kCOLOR_WHITE
        temp.isUserInteractionEnabled = false
        temp.backgroundColor = kCOLOR_CLEAR
        return temp
    }()
    
    lazy var pickerTableView: UITableView = {
        let temp = UITableView()
        temp.delegate = self
        temp.dataSource = self
        temp.showsVerticalScrollIndicator = false
        temp.separatorStyle = .none
        return temp
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error!")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPannel()
        addLayOut()
    }
    
    /// 主要使用的初始化方法
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - model: 选择器的数据
    init(frame: CGRect,model:KKPickerModel) {
        super.init(frame:frame)
        self.model = model
        setUpPannel()
        addLayOut()
    }
    
    func setUpPannel()  {
        addSubview(pickerTableView)
    }
    
    func addLayOut()  {
        pickerTableView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalToSuperview()
        }
    }
    
    func addUnitsLable() {
        addSubview(unitLabel)
        
        unitLabel.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(kWINDOW_WIDTH/2)
        }
    }
    
    func addBlureTheEdges() {
        let frame = CGRect.init(x: 0, y: 54.5, width: kWINDOW_WIDTH, height: 55.5)
        let fullFrame = CGRect.init(x: 0, y: 0, width: kWINDOW_WIDTH, height: 167)
        let path = UIBezierPath.init(rect: fullFrame)
        let reservePath = UIBezierPath.init(roundedRect: frame, cornerRadius: 5.0)
        path.append(reservePath)
        path.usesEvenOddFillRule = true
        
        let layer = CAShapeLayer.init(layer: pickerTableView.layer)
        layer.path = path.cgPath
        layer.fillColor = kCOLOR_WHITE.cgColor
        layer.opacity = 0.7
        layer.fillRule = kCAFillRuleEvenOdd
        self.layer.addSublayer(layer)
    }
    
    func gradientLayer() {
        let layer = CAGradientLayer.init(layer: pickerTableView.layer)
        layer.colors = [kCOLOR_WHITE.cgColor,kCOLOR_CLEAR.cgColor,kCOLOR_WHITE.cgColor]
        layer.startPoint = CGPoint.init(x: 0, y: 0)
        layer.endPoint  = CGPoint.init(x: 0, y: 1.0)
        layer.locations = [0.0,0.5,0.97,1.0]
        layer.frame = CGRect.init(x: 0, y: 0, width: kWINDOW_WIDTH, height: 167)
        layer.type = kCAGradientLayerAxial
        self.layer.addSublayer(layer)
    }

    func setContentEdgeInset(cell:KKColumnPickerCell?,alignment:NSTextAlignment)  {
        if let _ = model, let tempCell = cell {
            tempCell.setContentLableEdgeInset(aligment: alignment)
        }
    }
    
    /*s初始化的时候，默认选中的索引*/
    func updateCurrentIndex(index:Int) {
        let index_path = IndexPath.init(row: index, section: 0)
        let cell:KKColumnPickerCell = self.pickerTableView.cellForRow(at: index_path) as! KKColumnPickerCell
        cell.contentLabel.textColor = KCOLOR_TINT_COLOR
        if indexPath!.row <= datas[0].count {
            self.pickerTableView.scrollToRow(at: index_path, at: .middle, animated: true)
        }
        self.indexPath?.row = index
    }
    
    func pickDatas(model:KKPickerModel) {
        if let localDelegate = self.delegate,let currentModel = self.model {
            localDelegate.pickDatas(model: currentModel)
        }
    }
}


extension KKPickerSubView: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 167/3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[self.indexPath?.section ?? 0].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identtifier = "identtifier"
        var cell:KKColumnPickerCell? = tableView.dequeueReusableCell(withIdentifier: identtifier) as? KKColumnPickerCell
        if cell == nil {
            cell = KKColumnPickerCell.init(style: .default, reuseIdentifier: identtifier)
        }
        cell?.selectionStyle = .none
        let content = datas[self.indexPath?.section ?? 0][indexPath.row]
        cell?.updateDatas(text:content)
//        if self.indexPath?.section == 0 {
//            setContentEdgeInset(cell: cell, alignment: .right)
//        }
//        else{
//            setContentEdgeInset(cell: cell, alignment: .left)
//        }
        return cell!
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        changeSelected(scrollView: scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        changeSelected(scrollView: scrollView)
    }
    
    func changeSelected(scrollView: UIScrollView) {
        let tableView = scrollView as! UITableView
        let deltaH = Int(scrollView.contentOffset.y) % 55
        let lineNumber = Int(scrollView.contentOffset.y / 55.0) + 1

        if deltaH >= 55/2 {
            for visualCell in tableView.visibleCells  {
                let temp = visualCell as! KKColumnPickerCell
                temp.contentLabel.textColor = kCOLOR_TEXT_FIRST
            }

            let indexPath = IndexPath.init(row: lineNumber + 1, section: 0)
            if indexPath.row <= datas[0].count {
                self.indexPath?.row = indexPath.row
                tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                pickDatas(model: self.model!)
            }
            if let cell = tableView.cellForRow(at: indexPath) as? KKColumnPickerCell{
                cell.contentLabel.textColor = KCOLOR_TINT_COLOR
            }
        }
        else{
            for visualCell in tableView.visibleCells  {
                let temp = visualCell as! KKColumnPickerCell
                temp.contentLabel.textColor = kCOLOR_TEXT_FIRST
            }
            let indexPath = IndexPath.init(row: lineNumber , section: 0)
            if indexPath.row <= datas[0].count {
                self.indexPath?.row = indexPath.row
                tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
                pickDatas(model: self.model!)
            }
            if let cell = tableView.cellForRow(at: indexPath) as? KKColumnPickerCell{
                cell.contentLabel.textColor = KCOLOR_TINT_COLOR
            }
        }
    }
    
}
