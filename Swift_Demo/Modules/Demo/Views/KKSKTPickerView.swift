//
//  KKSKTPickerView.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKSKTPickerView: BaseView,KKPickerViewDataProtocol {
   
    lazy var pickerView:UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let datas = KKSKTSelectorModel.datas
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    // MARK:  update pickerView datas
    func updateDatas(model: Any) {
        
    }
}


extension KKSKTPickerView:UIPickerViewDelegate,UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return kWINDOW_WIDTH
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 55
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.datas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.datas[row]
    }
    
}
