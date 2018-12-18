//
//  RyCellProtocol.swift
//  RysnSleep
//
//  Created by Noverre on 2018/1/2.
//  Copyright © 2018年 Rysn. All rights reserved.
//

import UIKit

protocol RyCellProtocol: class{
    func update(withData data: RyCellDataBaseProtocol)
    static var defaultReuseIdentifier:String { get }
    static func cellHeightWithTableViewWidth(_ width: CGFloat, _ cellData: RyCellDataBaseProtocol?) -> CGFloat
}

protocol RyCellDataBaseProtocol {
    var identifier: String? {get set}
    func cellType(userInfo:[String: Any]?) -> (UITableViewCell & RyCellProtocol).Type
}

protocol RyDefaultReuseIdentifierAable{
    static var defaultReuseIdentifier: String {get}
}

extension RyDefaultReuseIdentifierAable{
    static var defaultReuseIdentifier: String{
        return "defaultReuseIdentifier." + String(describing: self)
    }
}

extension UICollectionReusableView: RyDefaultReuseIdentifierAable{
    
}
