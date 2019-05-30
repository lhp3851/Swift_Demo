//
//  KKContactsManager.swift
//  Swift_Demo
//
//  Created by Jerry on 2019/5/27.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit
import Contacts
import RxSwift


class KKContactsManager: NSObject {

    static let shared: Reactive<KKContactsManager> = Reactive<KKContactsManager>(KKContactsManager())
    
    lazy var status:CNAuthorizationStatus = {
        return CNContactStore.authorizationStatus(for: CNEntityType.contacts)
    }()
    
    let authorizable = Completable.create { (completable) -> Disposable in
        CNContactStore().requestAccess(for: .contacts) { (complete, error) in
            if complete {
                completable(.completed)
            }
            else{
                completable(.error(error ?? NSError() as Error))
            }
        }
       
        return Disposables.create {}
    }
    
    func getContacts() {
        if status == .authorized {
            
        }
        else{
            authorizable.subscribe(onCompleted: {
                
            }) { (error) in
                
            }.dispose()
        }
    }
    
    
}
