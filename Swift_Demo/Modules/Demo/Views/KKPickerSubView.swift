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

    fileprivate var drageEnd = false
    fileprivate var decelerateEnd = false
    
    var indexPath:IndexPath? = IndexPath.init(row: 1, section: 0) {
        didSet{
            if let currentModel = self.model {
                currentModel.selectIndex = indexPath!
            }
        }
    }
    
    weak var delegate:KKPickerDataProtocol?
    
    private let pickerViewHeight:CGFloat = 297
    
    var model:KKPickerModel? 
    
    override func didMoveToSuperview() {
        let index = self.model?.defaultIndex[self.indexPath?.section ?? 0]
        //self.pickDatas(model: self.model!) // 默认选中的数据,由 defaultIndex 获取
        self.updateCurrentIndex(index: (index ?? 1))
    }
    
    var datas: [[String]]! {
        return self.model!.datas as? [[String]]
    }

    
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
    
    /*s初始化的时候，默认选中的索引*/
    func updateCurrentIndex(index:Int) {
        let index_path = IndexPath.init(row: index , section: 0)
        if index_path.row <= datas[0].count {
            var scroll_index_path = index_path
            if scroll_index_path.row > 1{
                scroll_index_path.row -= 1
            }
            self.pickerTableView.scrollToRow(at: scroll_index_path, at: .top, animated: false)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            let cell:KKColumnPickerCell = self.pickerTableView.cellForRow(at: index_path) as! KKColumnPickerCell
            cell.contentLabel.textColor = KCOLOR_TINT_COLOR
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
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
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
        return cell!
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        drageEnd = true
        if !decelerate {
            drageEnd = false
            changeSelected(scrollView: scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        decelerateEnd = true
        if (drageEnd && decelerateEnd) {
            drageEnd = false
            decelerateEnd = false
            changeSelected(scrollView: scrollView)
        }
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
