//
//  KKDynamicStaticFeatures.swift
//  Swift_Demo
//
//  Created by sumian on 2019/6/14.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

// MARK: -  协议·拓展

protocol MyProtocol {
    
    func testFuncA()
    
}

extension MyProtocol {
    
    func testFuncA() {
        print("MyProtocol's testFuncA")
    }
    
    func testFuncB() {
        print("MyProtocol's testFuncB")
    }
    
}


class MyClass: MyProtocol {
    
    func testFuncA() {
        print("MyClass's testFuncA")
    }
    
    func testFuncB() {
        print("MyClass's testFuncB")
    }
    
}

class KKDynamicStaticFeatures: NSObject {
    
    func test() {
        let object: MyProtocol = MyClass()
        object.testFuncA()
        object.testFuncB()
    }
    
}

