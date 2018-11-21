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
    
    lazy var listView : BaseTableview = {
        let view = BaseTableview.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var pickerView: KKPickerView = {
        let temp = KKPickerView.init(frame: CGRect.zero, title: "SKT", datas: "")
        temp.delegate = self
        return temp
    }()
    
    var listDatas = KKSelectorModel.groupDatas
    
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
        if let window = UIWindow.getCurrentWindow() {
            self.translucentView.addSubview(pickerView)
            window.addSubview(self.translucentView)
        }
        
    }
    
    func setConstraints() -> Void {
        pickerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(400.0)
        }
        
        self.listView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
            } else {
                make.edges.equalTo(self.view)
            }
//            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
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
//            showPicker(type: SelectorType(rawValue: type)!)
            showPickerView()
        }
    }
    
    func showPickerView()  {
        print(self.translucentView)
        self.translucentView.isHidden = false
    }
    
    func showPicker(type whitType: SelectorType) {
        switch  whitType{
        case .education:
            print(whitType)
        case .address:
            print(whitType)
        case .date:
            print(whitType)
        case .time:
            print(whitType)
        case .dateAndTime:
            print(whitType)
        case .weight:
            print(whitType)
        case .stature:
            print(whitType)
        default:
            print(whitType)
        }
    }
}

extension KKSelectorViewController: KKPickerViewProtocol{
    func pickDatas(model: Any) {
        print("model:",model)
    }
}
