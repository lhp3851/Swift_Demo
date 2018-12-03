//
//  KKPickerSubView.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/26.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit


class KKPickerSubView: BaseView {

    private let pickerViewHeight:CGFloat = 297
    
    var needUnits:Bool = false
    
    var datas: [[String]]! {
        var dataSource = [[String]]()
        let model = KKStaturePickerModel().datas as! [String]
        dataSource.append(model)
        return dataSource
    }
    
    lazy var unitLabel:UILabel = {
        let temp = UILabel()
        temp.text = KKStaturePickerModel().unit
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
    
    
    init() {
        let frame = CGRect.init(x: 0, y: kWINDOW_HEIGHT, width: kWINDOW_WIDTH, height: pickerViewHeight)
        super.init(frame: frame)
        setUpPannel()
        addLayOut()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPannel()
        addLayOut()
    }
    
    init(frame: CGRect,needUnits:Bool) {
        super.init(frame: frame)
        self.needUnits = needUnits
        setUpPannel()
        addLayOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error!")
    }
    
    func setUpPannel()  {
        addSubview(pickerTableView)
        if needUnits {
            addUnitsLable()
        }
        addSubview(horizoneLineTop)
        addSubview(horizoneLineBottom)
        addBlureTheEdges()
    }
    
    func addLayOut()  {
        pickerTableView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalToSuperview()
        }
        
        horizoneLineTop.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(54.5)
        }
        
        horizoneLineBottom.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(horizoneLineTop.snp.bottom).offset(54.5)
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

    func setContentEdgeInset(cell:KKColumnPickerCell?)  {
        if needUnits, let tempCell = cell {
            tempCell.setContentLableEdgeInset()
        }
    }
}


extension KKPickerSubView: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.frame.height/3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identtifier = "identtifier"
        var cell:KKColumnPickerCell? = tableView.dequeueReusableCell(withIdentifier: identtifier) as? KKColumnPickerCell
        if cell == nil {
            cell = KKColumnPickerCell.init(style: .default, reuseIdentifier: identtifier)
        }
        cell?.selectionStyle = .none
        let content = datas[0][indexPath.row]
        cell?.updateDatas(text:content)
        setContentEdgeInset(cell: cell)
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
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            let cell = tableView.cellForRow(at: indexPath) as! KKColumnPickerCell
            cell.contentLabel.textColor = KCOLOR_TINT_COLOR
        }
        else{
            for visualCell in tableView.visibleCells  {
                let temp = visualCell as! KKColumnPickerCell
                temp.contentLabel.textColor = kCOLOR_TEXT_FIRST
            }
            let indexPath = IndexPath.init(row: lineNumber , section: 0)
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            let cell = tableView.cellForRow(at: indexPath) as! KKColumnPickerCell
            cell.contentLabel.textColor = KCOLOR_TINT_COLOR
        }
    }
    
}
