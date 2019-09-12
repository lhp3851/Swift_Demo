//
//  KKDemoViewController.swift
//  Swift_Demo
//
//  Created by Jerry on 2017/11/21.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class KKDemoViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    lazy var listView : BaseTableview = {
        let view = BaseTableview.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var listDatas = KKDemoModel.groupDatas
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func initData() {
        super.initData()
        
    }
    
    override func initPannel() {
        super.initPannel()
//        self.navigationItem.leftBarButtonItem = BarButtonItem().itemWithType(type: .BarButtomeTypePhone, title: "", selector: #selector(getContacts), target: self)
        self.navigationItem.rightBarButtonItem = BarButtonItem().itemWithType(type: .BarButtomeTypeWithTitle, title: "Demo", selector: #selector(demo), target: self)
        
        self.view.addSubview(self.listView)
        
        self.setConstraints()
    }
    
    func setConstraints() -> Void {
        self.listView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    
    
    
    //MARK: 功能方法
    @objc func demo() -> Void {
        
    }
    
    
    //MARK: UITableViewDataSource , UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.yfit
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let subDicItem = self.listDatas[section]
        let item:[String] = subDicItem[subDicItem.keys.first!] as! [String]
        return item.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.listDatas[section].keys.first
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        }
        let subDicItem = self.listDatas[indexPath.section]
        let item:[String] = subDicItem[subDicItem.keys.first!] as! [String]
        cell?.textLabel?.text = item[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let subDicItem = self.listDatas[indexPath.section]
        let item:[String] = subDicItem[subDicItem.keys.first!] as! [String]
        let vc = BaseViewController.getClass(objectName: item[indexPath.row])
        vc.title = item[indexPath.row]
        BaseViewController.jumpViewController(sourceViewConrroller: self, destinationViewController: vc, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

  

}
