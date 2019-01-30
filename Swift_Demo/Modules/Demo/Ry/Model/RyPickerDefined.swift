//
//  RyPickerDefined.swift
//  Swift_Demo
//
//  Created by sumianiOS1 on 2018/12/18.
//  Copyright © 2018年 Jerry. All rights reserved.
//

import UIKit

typealias RyListItem = RyPickerListable & RyCellDataBaseProtocol

enum RyPickerViewItemType {
    case holder
    case unit
    case list
}

struct RyPickerInset {
    let left: RyPickerViewItemWidth
    let right: RyPickerViewItemWidth
    static var zero: RyPickerInset{
        return RyPickerInset(.zero, .zero)
    }
    init(_ left: RyPickerViewItemWidth, _ right: RyPickerViewItemWidth) {
        self.left = left
        self.right = right
    }
}

enum RyPickerViewItemWidth: Equatable{
    //比例 （factor： 0 ～ 1）
    case scale(factor: CGFloat)
    //固定宽度
    case fixed(width: CGFloat)
    //平均分配剩余的
    case flexible
    
    case zero
    
    static func == (lhs: RyPickerViewItemWidth, rhs: RyPickerViewItemWidth) -> Bool {
        switch lhs {
        case .zero:
            if case .zero = rhs{
                return true
            }
            return false
        case .flexible:
            if case .flexible = rhs{
                return true
            }
            return false
        case .scale(let factor):
            if case let .scale(factor: rfactor) = rhs, factor == rfactor{
                return true
            }
            return false
        case .fixed(let width):
            if case let .fixed(width: rwidth) = rhs, width == rwidth{
                return true
            }
            return false
        }
    }
    
    func width(in length: CGFloat, flexibleWidth: CGFloat) -> CGFloat{
        switch self {
        case .fixed(let width):
            return width
        case .scale(let factor):
            return factor * length
        case .zero:
            return 0
        case .flexible:
            return flexibleWidth
        }
    }
    
    func width(in length: CGFloat, widths:[RyPickerViewItemWidth]) -> CGFloat{
        switch self {
        case .fixed(let width):
            return width
        case .scale(let factor):
            return length * factor
        case .zero:
            return 0
        case .flexible:
            return RyPickerViewItemWidth.flexibleWidth(in: length,widths: widths)
        }
    }
    
    static func flexibleWidth(in length: CGFloat, widths:[RyPickerViewItemWidth]) -> CGFloat{
        var aWidth = length
        var count: CGFloat = 0
        for thisWidth in widths {
            let temp = thisWidth.width(in: length,flexibleWidth: -1)
            if temp != -1{
                aWidth = aWidth - temp
            }else if case .flexible = thisWidth{
                count = count + 1
            }
        }
        return count > 0 ? (aWidth / count) : 0
    }
}

extension Array where Element == RyPickerViewItemWidth{
    func totalWidth(in length: CGFloat, widths:[RyPickerViewItemWidth]) -> CGFloat{
        let flexibleWidth = RyPickerViewItemWidth.flexibleWidth(in: length, widths: widths)
        var temp: CGFloat = 0
        for thisWidth in self {
            temp = temp + thisWidth.width(in: length, flexibleWidth: flexibleWidth)
        }
        return temp
    }
}

protocol RyPickerViewItemScrollDelegate: NSObjectProtocol {
    func item(_ item: RyPickerViewBaseData, didSelectRow row: Int)
}

protocol RyPickerListable {
    var objInPicker: Any {get}
    var rowForObjInPicker: Int {get}
    var titleInPicker: String {get}
}

