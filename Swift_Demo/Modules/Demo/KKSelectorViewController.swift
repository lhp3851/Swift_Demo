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
    
    var listDatas = KKSelectorModel.groupDatas
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initData() {
        super.initData()
        
    }
    
    override func initPannel() {
        super.initPannel()
        
        self.view.addSubview(self.listView)
        
        self.setConstraints()
    }
    
    func setConstraints() -> Void {
        self.listView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
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
