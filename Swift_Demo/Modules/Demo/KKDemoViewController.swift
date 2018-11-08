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
        let view = BaseTableview.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var listDatas = KKBaseModel.groupDatas
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func initData() {
        super.initData()
        KKPasteBoardTool.copy(contents: "instance sumian")
        print(KKPasteBoardTool.getContents())
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
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    
    
    
    //MARK: 功能方法
    @objc func demo() -> Void {
        print("demo~")
    }
    
    
    //MARK: UITableViewDataSource , UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kFIT_INSTANCE.fitHeight(height: 50.0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listDatas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDatas[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.listDatas[section][0]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = self.listDatas[indexPath.section][indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = BaseViewController.getClass(objectName: self.listDatas[indexPath.section][indexPath.row])
        BaseViewController.jumpViewController(sourceViewConrroller: self, destinationViewController: vc, animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

  

}
