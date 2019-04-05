//
//  String+Extension.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/9/22.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import Foundation
import UIKit

enum ValidatedType {
    case Email
    case MobilePhoneNumber
    case FixedPhone
}

extension String {
    //MARK:本地化
    static func locallized(locallized:String) -> String {
        let locallizedString = NSLocalizedString(locallized, comment: locallized)
        return locallizedString
    }
    //本地化
    func locallized() -> String {
        let lable : String = self
        let locallizedString = NSLocalizedString(lable, comment: lable)
        return locallizedString
    }
    
    //MARK:计算文字尺寸
    //固定宽度计算文字高度
    func getTextHeigh(font:UIFont,width:CGFloat) -> CGFloat {
        let normalText: String = self
        let size = CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context:nil).size
        return stringSize.height
    }
    //固定高度计算文字宽度
    func getTextWidth(font:UIFont,height:CGFloat) -> CGFloat {
        
        let normalText: String = self
        let size = CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context:nil).size
        return stringSize.width
    }
    
    //MARK: 手机号码、邮箱有效性验证
    static func validateText(validatedType type: ValidatedType, validateString: String) -> Bool {
        if validateString.isEmpty {
            return false
        }
        
        do {
            let pattern: String
            if type == ValidatedType.Email {
                pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            }
            else if type == ValidatedType.MobilePhoneNumber{
                pattern = "^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}$"
            }
            else if type == ValidatedType.FixedPhone {
                pattern = "^(0\\d{2}-\\d{8}(-\\d{1,4})?)|(0\\d{3}-\\d{7,8}(-\\d{1,4})?)$"
            }
            else{
                pattern = "."
            }
            let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: validateString, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, validateString.count))
            return matches.count > 0
        }
        catch {
            return false
        }
    }
    
    
    /// 判断移动电话是不是有效
    ///
    /// - Parameter phone: 电话号码
    /// - Returns: 是否有效
    static func isValideMobilePhone(phone:String) -> Bool {
        if phone.isEmpty {
            return false
        }
        return self.validateText(validatedType: ValidatedType.MobilePhoneNumber, validateString: phone)
    }
    
    static func isValidatePassword(password:String) -> Bool {
        if password.isEmpty {
            return false
        }
        
        if (password.count >= 6 && password.count <= 22) {
            return true
        }
        
        return false
    }

    
    //MARK:汉字转拼音
    /*let kCFStringTransformStripCombiningMarks: CFString! //删除重音符号
    let kCFStringTransformToLatin: CFString! //中文的拉丁字母
    let kCFStringTransformFullwidthHalfwidth: CFString!//全角半宽
    let kCFStringTransformLatinKatakana: CFString!//片假名拉丁字母
    let kCFStringTransformLatinHiragana: CFString!//平假名拉丁字母
    let kCFStringTransformHiraganaKatakana: CFString!//平假名片假名
    let kCFStringTransformMandarinLatin: CFString!//普通话拉丁字母
    let kCFStringTransformLatinHangul: CFString!//韩文的拉丁字母
    let kCFStringTransformLatinArabic: CFString!//阿拉伯语拉丁字母
    let kCFStringTransformLatinHebrew: CFString!//希伯来语拉丁字母
    let kCFStringTransformLatinThai: CFString!//泰国拉丁字母
    let kCFStringTransformLatinCyrillic: CFString!//西里尔拉丁字母
    let kCFStringTransformLatinGreek: CFString!//希腊拉丁字母
    let kCFStringTransformToXMLHex: CFString!//转换为XML十六进制字符
    let kCFStringTransformToUnicodeName: CFString!//转换为Unicode的名称
    @availability(iOS, introduced=2.0)
    let kCFStringTransformStripDiacritics: CFString!//转换成不带音标的符号*/
 
    //汉字转拼音
    static func transformToPinYinFromChinese(chinese:String) -> String
    {
        let pinyin = (chinese.mutableCopy()) as! CFMutableString
        CFStringTransform(pinyin , nil, kCFStringTransformToLatin, false)//转出来后带声调
        CFStringTransform(pinyin, nil, kCFStringTransformStripCombiningMarks, false)//去掉声调
        print(chinese,pinyin,(pinyin as String).uppercased())
        return (pinyin as String).uppercased();
    }
    
    //汉字转拼音带声调
    static func transformToPinYinFromChineseWithTone(chinese:String) -> String
    {
        let pinyin = (chinese.mutableCopy()) as! CFMutableString
        CFStringTransform(pinyin , nil, kCFStringTransformToLatin, false)
        print(chinese,pinyin,(pinyin as String).uppercased())
        return (pinyin as String).uppercased();
    }
    
    // 指定文本宽度，计算文本的高度
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    // 指定文本高度，计算文本的宽度
    func width(withConstraniedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin,.truncatesLastVisibleLine], attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
}
