//
//  ProfileViewes.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/17.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class ProfileViewes: BaseView,UITableViewDelegate,UITableViewDataSource {

    lazy var profileTableView:BaseTableview = {
        let view = BaseTableview.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var  datas = ProfileModle.getModelFromDatas()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initPannel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }

    func initPannel() -> Void {
        self.addSubview(self.profileTableView)
        
        self.setConstraints()
        
    }
    
    func setConstraints() -> Void {
        self.profileTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    
    //    MAKR:tableviewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kFIT_INSTANCE.fitHeight(height: 60.0)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kFIT_INSTANCE.fitHeight(height: 20.0)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return  nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifiler = "identifiler"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifiler)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifiler)
        }
        cell?.accessoryType = .disclosureIndicator
        let model : ProfileModle = self.datas[indexPath.section][indexPath.row]
        cell?.textLabel?.text = model.sbuTitle
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var VC = BaseViewController()
        
        let model : ProfileModle = self.datas[indexPath.section][indexPath.row]
        switch model.sbuTitle {
        case "设置":
            VC = StorePageViewController() as BaseViewController
        default: 
            VC = StorePageViewController() as BaseViewController
        }
        BaseViewController.jumpViewController(sourceViewConrroller: self.viewController()!, destinationViewController: VC, animated: true)
    }
    
    
    
}
