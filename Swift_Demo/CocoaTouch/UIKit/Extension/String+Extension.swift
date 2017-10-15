//
//  StringExtension.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/11.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import Foundation

enum ValidatedType {
    case Email
    case MobilePhoneNumber
    case FixedPhone
}

extension String{
    //固定宽度计算文字高度
    func getTextHeigh(font:UIFont,width:CGFloat) -> CGFloat {
        
        let normalText: String = self
        let size = CGSize.init(width: width, height: 10000)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context:nil).size
        return stringSize.height
    }
    //固定高度计算文字宽度
    func getTextWidth(font:UIFont,height:CGFloat) -> CGFloat {
        
        let normalText: String = self
        let size = CGSize.init(width: 1000, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context:nil).size
        return stringSize.width
    }
    
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
            let matches = regex.matches(in: validateString, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, validateString.characters.count))
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
        
        if (password.characters.count >= 6 && password.characters.count <= 22) {
            return true
        }
        
        return false
    }
    
    static func transformToPinYinFromChinese(chinese:String) -> String
    {
        let pinyin = (chinese.mutableCopy()) as! CFMutableString
        CFStringTransform(pinyin , nil, kCFStringTransformMandarinLatin, false)
        print(chinese,pinyin)
        CFStringTransform(pinyin , nil, kCFStringTransformStripCombiningMarks, false)
        print((pinyin as String).uppercased())
        return (pinyin as String).uppercased();
    }
    
    
}
