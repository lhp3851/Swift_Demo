//
//  KKPromisKitViewController.swift
//  Swift_Demo
//
//  Created by Jerry on 2019/5/29.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit
import CoreLocation
import PromiseKit

extension CLLocationManager {
    static func promise() -> Promise<[CLLocation]> {
        return PMKCLLocationManagerProxy().promise
    }
}

class PMKCLLocationManagerProxy: NSObject, CLLocationManagerDelegate {
    fileprivate let (promise, seal) = Promise<[CLLocation]>.pending()
    private var retainCycle: PMKCLLocationManagerProxy?
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        retainCycle = self
        manager.delegate = self // does not retain hence the `retainCycle` property
        
        promise.ensure {
            // ensure we break the retain cycle
            self.retainCycle = nil
        }.done { (locations) in
            locations.forEach({ (location) in
                print("\(location)")
            })
        }.catch { (error) in
            print("\(error)")
        }
    }
    
    internal func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        seal.fulfill(locations)
    }
    
    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        seal.reject(error)
    }
}

class KKPromisKitViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        firstly {
            initData()
        }.done { (error) in
            self.initPannel()
        }.catch { (error) in
            print("\(error)")
        }
        
       
    }
    
    func initPannel() -> Promise<Void> {
        return Promise()
    }
    
    func initData() -> Promise<Void> {
        return Promise()
    }

}
