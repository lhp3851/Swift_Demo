//
//  KKSelectorViewController.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKSelectorViewController: BaseViewController {

    var vcTitle = NSStringFromClass(KKSelectorViewController.self)
    let pickerViewHeight:CGFloat = 297
    var pickerType:SelectorType!
    var subViewNumber: Int = 1
    
    lazy var listView : BaseTableview = {
        let view = BaseTableview.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var pickerView: KKPickerView = {
        let frame = CGRect.init(x: 0, y: kWINDOW_HEIGHT, width: kWINDOW_WIDTH, height: pickerViewHeight)
        let temp = KKPickerView.init(frame: CGRect.zero, type:pickerType, delegate: self, dataSource: self)
        temp.partNumber = subViewNumber
        temp.setSubViewes()
        return temp
    }()
    
    var listDatas = KKPickerModel.groupDatas
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConstraints()
    }
    
    override func initData() {
        super.initData()
    }
    
    override func initPannel() {
        super.initPannel()
        self.view.addSubview(self.listView)
    }
    
    
    
    func setConstraints() -> Void {
        self.listView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
            } else {
                make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
            }
        }
    }
    
    func setUpPickerView() {
        if let window = UIWindow.getCurrentWindow() {
            self.translucentView.addSubview(pickerView)
            window.addSubview(self.translucentView)
        }
        pickerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(pickerViewHeight)
        }
    }
}


extension KKSelectorViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let key = listDatas.keys.first {
            let datas = listDatas[key]
            return datas?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listDatas.keys.first
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        if let key = listDatas.keys.first {
            let subDicItem = self.listDatas[key]
            cell?.textLabel?.text = subDicItem![indexPath.row]
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let key = listDatas.keys.first {
            let subDicItem = self.listDatas[key]
            let type = subDicItem![indexPath.row]
            showPicker(type: SelectorType(rawValue: type)!)
        }
    }
    
    func showPicker(type withType: SelectorType) {
        pickerType = withType
        if withType == SelectorType.stature{
            subViewNumber = 2
        }
        else{
            subViewNumber = 1
        }
        setUpPickerView()
        self.translucentView.isHidden = false
    }
}

extension KKSelectorViewController: KKPickerViewProtocol,KKPickerViewDataProtocol{
    func didSelect(model: Any) {
        dump(model)
        self.translucentView.isHidden = true
    }
    
    func subViewWith(cellForRowAt indexPath: IndexPath?,type:SelectorType) -> (UIView) {
        switch type {
        case .skt:
            let pickerView = KKSKTPickerView.init(frame: CGRect.zero)
            return pickerView
        case .education:
            let pickerView = KKEducationPickerView.init(frame: CGRect.zero)
            return pickerView
        case .gender:
            let pickerView = KKGenderPickerView.init(frame: CGRect.zero)
            return pickerView
        case .stature:
            let pickerView = KKStaturePickerView.init(frame: CGRect.zero, needUnits: true)
            return pickerView
            
        case .address:
            let pickerView = KKAddressPickerView.init(frame: CGRect.zero, needUnits: false)
            return pickerView
        case .date:
            let pickerView = KKDatePickerView.init(frame: CGRect.zero)
            return pickerView
       
        case .weight:
            let pickerView = KKWeightPickerView.init(frame: CGRect.zero,component:2)
            return pickerView
        
        default:
            return UIView()
        }
    }
}
