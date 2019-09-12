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
        temp.frame = CGRect.init(x: 0, y: 0, width: UIScreen.width, height: headHeight)
        let image = UIImage.named("navigation_bar")
        temp.image = image
        return temp
    }()
    
    lazy var footerView:UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.yellow
        temp.frame = CGRect.init(x: 0, y: 0, width: UIScreen.width, height: 20)
        return temp
    }()
    
    lazy var listView : BaseTableview = {
        let view = BaseTableview.init(frame: CGRect.zero, style: UITableView.Style.plain)
        view.delegate = self
        view.dataSource = self
        view.tableHeaderView = headView
        view.tableFooterView = footerView
        view.contentInset = UIEdgeInsets.init(top: -knavi_status_bar_height, left: 0, bottom: 0, right: 0)
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
    
    var backGroundView:UIView {
        let subViewes:[UIView] = (navigationController?.navigationBar.subviews) ?? [UIView()]
        let view = subViewes.first
        view?.backgroundColor = UIColor.orange
        return view!
    }
    
    var isdragged:Bool = false
    
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
        view.addSubview(self.listView)
        setConstraints()
//        adjustSafeArea()
    }
    
    func setConstraints() -> Void {
        self.listView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    func adjustSafeArea() {
        if #available(iOS 11.0, *) {
            listView.contentInsetAdjustmentBehavior = .never
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
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            backGroundView.backgroundColor = UIColor.orange
            backGroundView.alpha = 1.0
        }
        else{
            var image = UIImage.named("navigation_bar")
            image = image.withRenderingMode(.alwaysTemplate)
            navigationController?.navigationBar.setBackgroundImage(image, for: .default)
            navigationController?.navigationBar.shadowImage = nil
            backGroundView.alpha = 1.0
            backGroundView.backgroundColor = UIColor.orange
        }
    }
    
    func setBackgroundAlpha(alpha:CGFloat){
        if let navigationBar = navigationController?.navigationBar,
           let barBackgroundView = navigationBar.subviews.first
        {
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isdragged = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if !isdragged {
            return
        }
        let alpha = (offset - knavi_status_bar_height)/(headHeight - knavi_status_bar_height)
        if offset >= knavi_status_bar_height {
            statusStyle = .default
            backGroundView.alpha = alpha
            listView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
        else if (offset > 0 && offset < knavi_status_bar_height){
            statusStyle = .lightContent
            backGroundView.alpha = 0
            listView.contentInset = UIEdgeInsets.init(top: -knavi_status_bar_height, left: 0, bottom: 0, right: 0)
        }
    }
}
