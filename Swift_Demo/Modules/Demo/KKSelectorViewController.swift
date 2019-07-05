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
        let view = BaseTableview.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    lazy var pickerView: KKPickerView = {
        let model = KKTimePickerModel.share
        let temp = KKPickerView.init(frame: CGRect.zero, model: model as! KKPickerViewDataSource, delegate: self)
        return temp
    }()

    lazy var ryPickerView:RyDatePickerView = {
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        let temp = RyPickerView.date(startDate: startDate, endDate: endDate)
        temp.delegate = self

//        let temp = RyPickerView.height
//        let items = (0...100).map({ (thisI) -> String in
//            return "\(thisI)"
//        })
//        let temp = RyPickerView.picker(with: items, pickerTitle: "")
//        let temp = RyPickerView.address
//        temp.delegate = self
//        temp.dateDataSource.delegate = self
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
                make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
            }
        }
    }

    func setUpPickerView() {
//        if let window = UIWindow.getCurrentWindow() {
//            self.translucentView.addSubview(pickerView)
//            window.addSubview(self.translucentView)
//        }
//        pickerView.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(pickerViewHeight)
//        }
    }

    func showPickerView(handler:Handler)  {
//        if let window = UIWindow.getCurrentWindow() {
//            self.translucentView.addSubview(ryPickerView)
//            window.addSubview(self.translucentView)
//        }
//        ryPickerView.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalToSuperview()
//            make.height.equalTo(pickerViewHeight)
//        }
//        handler(0.26)
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
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
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
//        self.translucentView.isHidden = false
//        showPickerView { (delay) in
////            DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
////                let indexPath = IndexPath.init(row: 91, section: 1)
////                self.ryPickerView.scrollTo(indexPath: indexPath)
////            })
//        }
        ryPickerView.show()
//        let vc = RyViewController_test()
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension KKSelectorViewController: KKPickerViewProtocol{

    func didSelect(model: Any, type: SelectorType) {
//        dump(model)
//        self.translucentView.isHidden = true
    }

}


extension KKSelectorViewController:RyPickerViewDelegate {
    func pickerView(didTapAction pickerView: RyPickerView){
        let temp = pickerView.selectedObjs.map { (thiObj) -> String in
            return thiObj.titleInPicker
        }

        let temp2 = pickerView.selectedObjs.map { (thiObj) -> Any in
            return thiObj.objInPicker
        }
        print(temp)
        print(temp2)
        

//        (pickerView as? RyDatePickerView)?.dateDataSource.reload(andFixAtDate: Date())
//        let dataSource = ryPickerView.dataSource as! RyDatePickerDataSource
//        dataSource.startDate = Calendar.current.date(bySettingHour: 14, minute: 40, second: 0, of: Date())!
//        dataSource.endDate = Calendar.current.date(bySettingHour: 23, minute: 10, second: 0, of: Date())!
//        pickerView.itemView(forComponent: 0).reload(andFixAtTitle: "21")
//        pickerView.itemView(forComponent: 1).reload(andFixAtTitle: "10")
    }
}

extension KKSelectorViewController: RyDatePickerSourceDelegate{
    func datePickerDataSource(_ dataSoure: RyDatePickerDataSource, didSelectedDateChanged selectedDate: Date) {
        print("didSelectedDateChanged \(selectedDate)")
    }
}
