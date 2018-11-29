//
//  KKColumnPickerView.swift
//  Swift_Demo
//
//  Created by sumian on 2018/11/27.
//  Copyright © 2018 Jerry. All rights reserved.
//

import UIKit

class KKColumnPickerView: KKPickerSubView {

    lazy var pickerView:UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        return view
    }()
    
    let datas = KKSKTPickerModel.localDatas
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpPannel()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init error")
    }
    
    func setUpPannel(){
        addSubview(pickerView)
    }
    
    func setUpConstraints(){
        pickerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

extension KKColumnPickerView: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.frame.height/3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identtifier = "identtifier"
        var cell:KKColumnPickerCell? = tableView.dequeueReusableCell(withIdentifier: identtifier) as? KKColumnPickerCell
        if cell == nil {
            cell = KKColumnPickerCell.init(style: .default, reuseIdentifier: identtifier)
            if indexPath.row == 1 {
                cell?.isFocoused = true
            }
            else{
                cell?.isFocoused = false
            }
            let content = datas[indexPath.row]
            cell?.updateDatas(text:content)
        }
        return cell!
    }
    
}
