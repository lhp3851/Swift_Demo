//
//  RyBaseTableViewCell.swift
//  RysnSleep
//
//  Created by Noverre on 2018/1/3.
//  Copyright © 2018年 Rysn. All rights reserved.
//

import UIKit
typealias RyCellOperationHandler = (_ cell:RyBaseTableViewCell,
    _ sender:UIView,
    _ info:Any?,
    _ completion:((Error?)->Void)? ) -> Void


class RyBaseTableViewCell: UITableViewCell,RyCellProtocol {    
    func update(withData data: RyCellDataBaseProtocol) {
        
    }
    
    /// cell,sender,info,completion
    var operationHandler: RyCellOperationHandler?
    
    class var defaultReuseIdentifier: String{
        return "defaultReuseIdentifier." + String(describing: self)
    }
    
    class func cellHeightWithTableViewWidth(_ width: CGFloat, _ cellData: RyCellDataBaseProtocol?) -> CGFloat{
        return 60
    }
}
