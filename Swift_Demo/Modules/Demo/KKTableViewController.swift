//
//  KKTableViewController.swift
//  Swift_Demo
//
//  Created by sumian on 2019/1/29.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class KKTableViewController: BaseViewController {

    let headHeight:CGFloat = 200.0
    
    var knavi_status_bar_height :CGFloat {
        let status_height:CGFloat = UIApplication.shared.statusBarFrame.height
        let navibar_height:CGFloat = navigationController?.navigationBar.bounds.height ?? 44.0
        return status_height + navibar_height
    }
    
    lazy var headView:UIImageView = {
        let temp = UIImageView()
        temp.frame = CGRect.init(x: 0, y: 0, width: kWINDOW_WIDTH, height: headHeight)
        let image = kIMAGE_WITH(name: "navigation_bar")
        temp.image = image
        return temp
    }()
    
    lazy var footerView:UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.yellow
        temp.frame = CGRect.init(x: 0, y: 0, width: kWINDOW_WIDTH, height: 20)
        return temp
    }()
    
    lazy var listView : BaseTableview = {
        let view = BaseTableview.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.delegate = self
        view.dataSource = self
        view.tableHeaderView = headView
        view.tableFooterView = footerView
        view.contentInset = UIEdgeInsetsMake(-knavi_status_bar_height, 0, 0, 0)
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    var statusStyle:UIStatusBarStyle = .lightContent {
        didSet{
            if statusStyle != oldValue {
                setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    lazy var _bgImageView:UIImageView = {
        let subviews = navigationController?.navigationBar.subviews
        let temp = subviews!.first
        return temp as? UIImageView ?? UIImageView()
    }()
    
    lazy var fakeNavi:UINavigationBar = {
        let temp:UINavigationBar = navigationController?.navigationBar.copy() as! UINavigationBar
        temp.alpha = 1.0
        return temp
    }()
    
    var listDatas = KKDemoModel.groupDatas
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar(translucent: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationBar(translucent: false)
    }
    
    override func initData() {
        
        super.initData()
        
    }
    
    override func initPannel() {
        super.initPannel()
        
        self.view.addSubview(self.listView)
        
        self.setConstraints()
        
//        adjustSafeArea()
    }
    
    func setConstraints() -> Void {
        self.listView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
    func adjustSafeArea() {
        if #available(iOS 11.0, *) {
//            listView.contentInsetAdjustmentBehavior = .never
        }
        else{
            self.defualtSetting()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return statusStyle
    }
    
    func navigationBar(translucent:Bool) {
        if translucent {
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.backgroundColor = UIColor.clear
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isOpaque = false
        }
        else{
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.isOpaque = true
        }
    }
    
    func setBackgroundAlpha(alpha:CGFloat){
        if let navigationBar = navigationController?.navigationBar,
           let barBackgroundView = navigationBar.subviews.first{
            if #available(iOS 11.0, *){
                if navigationBar.isTranslucent{
                    for view in barBackgroundView.subviews {
                        view.alpha = alpha
                    }
                }else{
                    barBackgroundView.alpha = alpha
                }
            } else {
                barBackgroundView.alpha = alpha
            }
        }
    }
}

//MARK: UITableViewDataSource , UITableViewDelegate
extension KKTableViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kFIT_INSTANCE.fitHeight(height: 50.0)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
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
}

extension KKTableViewController {
    //部分悬停： 头部悬停 底部悬停
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset.y
//        if offset > 0 && offset <= headHeight {
//            scrollView.contentInset = UIEdgeInsetsMake(-offset, 0, 0, 0)
//        }
//        else if (offset > headHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-headHeight, 0, 0, 0);
//        }
        
//        let subFrame:CGRect = listView.rectForRow(at: IndexPath.init(row: 0, section: 3))
//        let frame:CGRect = listView.convert(subFrame, to: listView.superview)
//        if frame.origin.y <= -headHeight {
//            listView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        }
//        else{
//            listView.contentInset = UIEdgeInsetsMake(0, 0, -headHeight, 0);
//        }
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let alpha = (offset - knavi_status_bar_height)/(headHeight - knavi_status_bar_height)
        if offset > knavi_status_bar_height {
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.barTintColor = UIColor.orange
            navigationController?.navigationBar.tintColor = UIColor.orange
            statusStyle = .default
//            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        else if (offset > 0 && offset < knavi_status_bar_height){
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.barTintColor = UIColor.clear
            navigationController?.navigationBar.tintColor = UIColor.clear
            statusStyle = .lightContent
//            scrollView.contentInset = UIEdgeInsetsMake(-knavi_status_bar_height, 0, 0, 0)
        }
        else{
            print("offset:",offset)
        }
    }
    
}
