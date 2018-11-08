//
//  ContactsTool.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/15.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import Contacts

class ContactsTool: NSObject {

    
    typealias CompleteHandler = ([[CNContact]]) -> ()
    static var completeHnadler : CompleteHandler?
    
    var localizedCollation:UILocalizedIndexedCollation = UILocalizedIndexedCollation.current()
    var indexTitiles = Array<String>()
    
    static let share = ContactsTool()
    private override init() {
        
    }
    
    class func accessStatus() -> CNAuthorizationStatus {
        return CNContactStore.authorizationStatus(for: CNEntityType.contacts)
    }
    
    class func getAutenticate() -> Void {
        guard CNAuthorizationStatus.authorized == self.accessStatus() else {
            CNContactStore().requestAccess(for: .contacts) { (complete, error) in
                if complete {
                    print("授权成功")
                }
                else{
                    print("授权失败")
                }
            }
            return
        }
    }
    
    class func getContacts(authenticatedHandler:@escaping CompleteHandler) -> Void{
        self.completeHnadler = authenticatedHandler
        self.autenticate()
    }
    
    private class func autenticate() -> Void {
        guard CNAuthorizationStatus.authorized == self.accessStatus() else {
            CNContactStore().requestAccess(for: .contacts) { (complete, error) in
                if complete {
                    print("授权成功")
                   self.loadContactsData()
                }
                else{
                    print("授权失败")
                }
            }
            print("第一次授权")
            return
        }
        
        DispatchQueue.global().async {
            self.loadContactsData()//异步获取数据，会快些
        }
    }
    
    class func loadContactsData() -> Void {
        var contacts : [CNContact] = Array()
        
        //获取授权状态
        let status = CNContactStore.authorizationStatus(for: .contacts)
        //判断当前授权状态
        guard status == .authorized else { return }
        
        //创建通讯录对象
        let store = CNContactStore()
        
        //获取Fetch,并且指定要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey,
                    CNContactOrganizationNameKey, CNContactJobTitleKey,
                    CNContactDepartmentNameKey, CNContactNoteKey, CNContactPhoneNumbersKey,
                    CNContactEmailAddressesKey, CNContactPostalAddressesKey,
                    CNContactDatesKey, CNContactInstantMessageAddressesKey]
        
        //创建请求对象
        //需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含CNKeyDescriptor类型的数组
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        
        //遍历所有联系人
        do {
            try store.enumerateContacts(with: request, usingBlock: {
                (contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
//                self.descrption(contact: contact)
                contacts.append(contact)
                
            })
        } catch {
            print(error)
        }
        let sortedContacts = ContactsTool.share.sortContacts(contacts: contacts)
        
        self.completeHnadler!(sortedContacts)
        
    }
    
    class func loadDatas() -> [[CNContact]] {

        var contacts : [CNContact] = Array()
        
        //获取授权状态
        let status = CNContactStore.authorizationStatus(for: .contacts)
        //判断当前授权状态
        guard status == .authorized else { return [] }
        
        //创建通讯录对象
        let store = CNContactStore()
        
        //获取Fetch,并且指定要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactNicknameKey,
                    CNContactOrganizationNameKey, CNContactJobTitleKey,
                    CNContactDepartmentNameKey, CNContactNoteKey, CNContactPhoneNumbersKey,
                    CNContactEmailAddressesKey, CNContactPostalAddressesKey,
                    CNContactDatesKey, CNContactInstantMessageAddressesKey
        ]
        
        //创建请求对象
        //需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含CNKeyDescriptor类型的数组
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        
        //遍历所有联系人
        do {
            try store.enumerateContacts(with: request, usingBlock: {
                (contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                //                self.descrption(contact: contact)
                contacts.append(contact)
                
            })
        } catch {
            print(error)
        }
        return ContactsTool.share.sortContacts(contacts: contacts)
    }
    
    func sortContacts(contacts:[CNContact]) -> [[CNContact]]{
        var tempContactsArray = [[CNContact]]()
        
        for _ in 0..<self.localizedCollation.sectionTitles.count {
            let array:[CNContact] = Array()
            tempContactsArray.append(array)
        }
        
        for contact in contacts {
            let section = self.localizedCollation.section(for: contact, collationStringSelector: #selector(getter: contact.familyName))
            var tempArray : [CNContact] = tempContactsArray[section]
            tempArray.append(contact)
            tempContactsArray[section] = tempArray
        }
        
        let tempContacts = tempContactsArray
        for i in 0..<self.indexTitiles.count {
            let sectionContacts = tempContacts[i]
            let sortedContactsForSection = self.localizedCollation.sortedArray(from: sectionContacts, collationStringSelector:  #selector(getter: CNContact.familyName))
            tempContactsArray[i] = sortedContactsForSection as! [CNContact]
        }
        return tempContactsArray
    }
    
    /// 联系人信息
    ///
    /// - Parameter contact: 联系人model
    private class func descrption(contact : CNContact) -> Void {
        //获取姓名
        let lastName = contact.familyName
        let firstName = contact.givenName
        print("姓名：\(lastName)\(firstName)")
        
        //获取昵称
        let nikeName = contact.nickname
        print("昵称：\(nikeName)")
        
        //获取公司（组织）
        let organization = contact.organizationName
        print("公司（组织）：\(organization)")
        
        //获取职位
        let jobTitle = contact.jobTitle
        print("职位：\(jobTitle)")
        
        //获取部门
        let department = contact.departmentName
        print("部门：\(department)")
        
        //获取备注
        let note = contact.note
        print("备注：\(note)")
        
        //获取电话号码
        print("电话：")
        for phone in contact.phoneNumbers {
            //获得标签名（转为能看得懂的本地标签名，比如work、home）
            var label = "未知标签"
            if phone.label != nil {
                label = CNLabeledValue<NSString>.localizedString(forLabel:
                    phone.label!)
            }
            
            //获取号码
            let value = phone.value.stringValue
            print("\t\(label)：\(value)")
        }
        
        //获取Email
        print("Email：")
        for email in contact.emailAddresses {
            //获得标签名（转为能看得懂的本地标签名）
            var label = "未知标签"
            if email.label != nil {
                label = CNLabeledValue<NSString>.localizedString(forLabel:
                    email.label!)
            }
            
            //获取值
            let value = email.value
            print("\t\(label)：\(value)")
        }
        
        //获取地址
        print("地址：")
        for address in contact.postalAddresses {
            //获得标签名（转为能看得懂的本地标签名）
            var label = "未知标签"
            if address.label != nil {
                label = CNLabeledValue<NSString>.localizedString(forLabel:
                    address.label!)
            }
            
            //获取值
            let detail = address.value
            let contry = detail.value(forKey: CNPostalAddressCountryKey) ?? ""
            let state = detail.value(forKey: CNPostalAddressStateKey) ?? ""
            let city = detail.value(forKey: CNPostalAddressCityKey) ?? ""
            let street = detail.value(forKey: CNPostalAddressStreetKey) ?? ""
            let code = detail.value(forKey: CNPostalAddressPostalCodeKey) ?? ""
            let str = "国家:\(contry) 省:\(state) 城市:\(city) 街道:\(street)"
                + " 邮编:\(code)"
            print("\t\(label)：\(str)")
        }
        
        //获取纪念日
        print("纪念日：")
        for date in contact.dates {
            //获得标签名（转为能看得懂的本地标签名）
            var label = "未知标签"
            if date.label != nil {
                label = CNLabeledValue<NSString>.localizedString(forLabel:
                    date.label!)
            }
            
            //获取值
            let dateComponents = date.value as DateComponents
            let value = NSCalendar.current.date(from: dateComponents)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
            print("\t\(label)：\(dateFormatter.string(from: value!))")
        }
        
        //获取即时通讯(IM)
        print("即时通讯(IM)：")
        for im in contact.instantMessageAddresses {
            //获得标签名（转为能看得懂的本地标签名）
            var label = "未知标签"
            if im.label != nil {
                label = CNLabeledValue<NSString>.localizedString(forLabel:
                    im.label!)
            }
            
            //获取值
            let detail = im.value
            let username = detail.value(forKey: CNInstantMessageAddressUsernameKey)
                ?? ""
            let service = detail.value(forKey: CNInstantMessageAddressServiceKey)
                ?? ""
            print("\t\(label)：\(username) 服务:\(service)")
        }
    }
    
    
    
}
