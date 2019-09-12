//
//  KKGenericsTool.swift
//  Swift_Demo
//
//  Created by Jerry on 2019/5/16.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

// MARK: - 关联类型协议
protocol Container {
    associatedtype ItemType:Equatable
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == ItemType
    func makeIterator() -> Iterator
}

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.ItemType == ItemType
    func suffix(_ size: Int) -> Suffix
}

// MARK: - 遵循关联类型协议的泛型结构体
struct Stack<Element:Equatable>: Container {//,Sequence,Equatable
    
    typealias ItemType = Element
    
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    typealias Iterator = StackIterator
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
    
    //conformance to the Container protocol--Iterator:Sequence
    func makeIterator() -> StackIterator<Element> {
        return StackIterator(container: self)
    }
    
    //conformance to the Equatable
    static func == (lhs: Stack<Element>, rhs: Stack<Element>) -> Bool{
        guard lhs.count == rhs.count else {return false}
        for idx in 0..<lhs.count {
            if lhs[idx] != rhs[idx] {
                return false
            }
        }
        return true
    }
}

// MARK: - 泛型迭代器
struct StackIterator<Item:Equatable>:IteratorProtocol {

    typealias Element = Item

    var index = 0
    
    var stackItem:Stack<Item>
    
    init(container:Stack<Item>) {
        self.stackItem = container
        index = self.stackItem.count
    }
    
    mutating func next() -> Item? {
        guard index > 0 else {
            return nil
        }
        if index > stackItem.count {index = stackItem.count}
        index -= 1
        return stackItem.pop()
    }
    
    //conformance to the Equatable
    static func == (lhs: StackIterator<Element>, rhs: StackIterator<Element>) -> Bool{
        guard lhs.stackItem.count == rhs.stackItem.count else {return false}
        for idx in 0..<lhs.stackItem.count {
            if lhs.stackItem[idx] != rhs.stackItem[idx] {
                return false
            }
        }
        return true
    }
}

// MARK: - 泛型方法
class KKGenericsTool: NSObject {

    func swap<T>(_ a: inout T, _ b: inout T) {
        let temp = a
        a = b
        b = temp
    }
    
    func stackTest() {
        var stackOfInts = Stack<Int>()
        stackOfInts.append(10)
        stackOfInts.append(20)
        stackOfInts.append(30)
        let suffix = stackOfInts.suffix(2)
        print(suffix,suffix.makeIterator())
        var iterator = stackOfInts.makeIterator()
        while let item = iterator.next() {
            print("下一个：",item)
        }
        print(stackOfInts)
    }
    
    func protocolTeslt() {
        let numbers = [10, 20, 30, 40, 50]
        let firstValue = \[Int].[0]
        print(numbers[keyPath: firstValue])     // 10
        
        let string = "Helloooo!"
        let firstChar = \String.[string.startIndex] // valid in Swift 4.1 or later
        print(firstChar)
    }
}

// MARK: - 后缀容器栈
extension Stack: SuffixableContainer {
    // Inferred that Suffix is Stack.
    // typealias Suffix = Stack
    func suffix(_ size: Int) -> Stack {
        var result = Stack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
}



