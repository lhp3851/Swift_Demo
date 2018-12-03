//
//  KKSKTPickerView.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKColumnsPickerView: UIView {
   
    lazy var pickerView:UIPickerView = {
        let view = UIPickerView()
        view.showsSelectionIndicator = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var contentLabel: UILabel  {
        let label = UILabel()
        label.font = kFONT_18
        label.textColor = kCOLOR_TEXT_FIRST
        label.backgroundColor = kCOLOR_WHITE
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    var datas:[[String]]!
    
    var selectedItem: [[String]]!
    
    var components:Int = 1
    
    var selectedIndex:IndexPath = IndexPath.init(row: 0, section: 0)
//    {
//        didSet{
//            selectedItem = datas[selectedRow]
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPannel()
        setUpConstraints()
    }
    
    init(frame: CGRect,component:Int) {
        super.init(frame: frame)
        self.components = component
        setUpPannel()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
    
    func setUpPannel(){
        addSubview(pickerView)
    }
    
    func setUpConstraints(){
        pickerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setAttr(content:String) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.foregroundColor:kCOLOR_TEXT_FIRST];
        let attrText = NSMutableAttributedString.init(string: content, attributes: attrs)
        return attrText
    }
}


extension KKColumnsPickerView:UIPickerViewDelegate,UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (kWINDOW_WIDTH/CGFloat(components))
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 55
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.components
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datas[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        for line in pickerView.subviews {
            if line.height < 1 {
                line.backgroundColor = KCOLOR_SEPERATE_LINE
            }
        }
        let label = contentLabel
        label.text = datas[component][row]
        if selectedIndex.row == row && selectedIndex.section == component {
            label.textColor = KCOLOR_TINT_COLOR
        }
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = IndexPath.init(row: row, section: component)
        let label:UILabel = pickerView.view(forRow: row, forComponent: component) as! UILabel
        label.attributedText = setAttr(content: datas[component][row])
        pickerView.reloadComponent(component)
    }

}
