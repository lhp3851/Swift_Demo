//
//  KKSelectorViewController.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/21.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKSelectorViewController: BaseViewController {
    
    typealias Handler = (TimeInterval) -> ()

    var vcTitle = NSStringFromClass(KKSelectorViewController.self)
    let pickerViewHeight:CGFloat = 297
    
    lazy var listView : BaseTableview = {
        let view = BaseTableview.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var pickerView: KKPickerView = {
        let model = KKTimePickerModel.share
        let temp = KKPickerView.init(frame: CGRect.zero, model: model as! KKPickerViewDataSource, delegate: self)
        return temp
    }()
    
    lazy var ryPickerView:RyPickerView = {
        let temp = RyPickerView.heightPicker
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
    
    func showPickerView(handler:Handler)  {
        if let window = UIWindow.getCurrentWindow() {
            self.translucentView.addSubview(ryPickerView)
            window.addSubview(self.translucentView)
        }
        ryPickerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(pickerViewHeight)
        }
        handler(0.26)
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
        self.translucentView.isHidden = false
        showPickerView { (delay) in
            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                let indexPath = IndexPath.init(row: 91, section: 1)
                self.ryPickerView.scrollTo(indexPath: indexPath)
            })
        }
    }
}

extension KKSelectorViewController: KKPickerViewProtocol{

    func didSelect(model: Any, type: SelectorType) {
        dump(model)
        self.translucentView.isHidden = true
    }
    
}
