//
//  RyPickerView.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/17.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit
import SnapKit

protocol RyPickerViewDelegate: NSObjectProtocol {
    func pickerView(didTapAction pickerView: RyPickerView)
}

class RyPickerView: RyPickerContentView {

    //delegate 还是要weak
    weak var delegate: RyPickerViewDelegate?
    
    var preferredHeight: CGFloat = 55 + 55 + 187
    
    @objc func onActionButton(sender: Any){
        let count = dataSource.numberOfComponents(in: self)
        for index in 0..<count{
            if dataSource.pickerView(self, itemViewForComponent: index).isDraging{
                return
            }
        }
        delegate?.pickerView(didTapAction: self)
    }
    
    override func setupSubview(){
        super.setupSubview()
        backgroundColor = RyUI.color.B1
        titleLabel.text = dataSource.titleOfPicker(in: self)
        addSubview(titleLabel)
        addSubview(actionButton)
    }
    
    override func frameOfContentView(in bounds: CGRect) -> CGRect {
        let contentViewH = bounds.height - 55 - 10 - 55 - 10
        return CGRect(x: 0, y: 55+10, width: bounds.width, height: contentViewH)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 55)
        actionButton.frame = CGRect(x: 0, y: bounds.height-55, width: bounds.width, height: 55)
    }
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = RyUI.color.T1
        temp.font = UIFont.systemFont(ofSize: 16)
        temp.textAlignment = .center
        temp.backgroundColor = RyUI.color.B2
        return temp
    }()
    
    lazy var actionButton:UIButton = {
        let temp = UIButton()
        temp.setTitle("确定", for: .normal)
        temp.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        temp.setTitleColor(RyUI.color.T1, for: .normal)
        temp.backgroundColor = RyUI.color.B2
        temp.addTarget(self, action: #selector(onActionButton(sender:)), for: .touchUpInside)
        return temp
    }()

    lazy var bgView: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(onBgViewTap(sender:)))
        tap.delegate = self
        temp.addGestureRecognizer(tap)
        return temp
    }()
}

extension RyPickerView: UIGestureRecognizerDelegate{
    
    func show(){
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        bgView.frame = keyWindow.bounds
        bgView.alpha = 0.5
        bgView.addSubview(self)
        frame = CGRect(x: 0, y: keyWindow.bounds.height,
                       width: keyWindow.bounds.size.width,
                       height: preferredHeight)
        let h = preferredHeight
        keyWindow.addSubview(bgView)
        UIView.animate(withDuration: 0.3) {
            self.bgView.alpha = 1
            self.frame = CGRect(x: 0, y: keyWindow.bounds.height-h,
                                width: keyWindow.bounds.size.width,
                                height: h)
        }
    }
    
    func hide(){
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = self.frame.offsetBy(dx: 0, dy: self.preferredHeight)
            self.bgView.alpha = 0
        }) { (_) in
            self.bgView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    @objc func onBgViewTap(sender: UITapGestureRecognizer){
        hide()
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let location = touch.location(in: bgView)
        if frame.contains(location){
            return false
        }
        return true
    }
}

extension RyPickerView{
    static func picker(with titles:[String], pickerTitle: String) -> RyPickerView{
        let container = RyListWidthContainer(.zero, .flexible, .zero)
        var items: [RyPickerRowData] = []
        for (index, thisTitle) in titles.enumerated() {
            items.append(RyPickerRowData(index: index, title: thisTitle, obj: thisTitle))
        }
        let listItem = RyPickerListData(dataSource: items,
                                        widthContainer: container)
        let cfg = RyPickerViewConfiguration(title: pickerTitle,items: [listItem])
        return RyPickerView(dataSource: cfg)
    }
}
