//
//  KKKeyPath.swift
//  Swift_Demo
//
//  Created by Jerry on 2019/5/18.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

struct Article {
    let title: String
    let body: String
    let image:UIImage?
}

class Paragraph {
    let title: String = ""
    let body: String = ""
    var image:UIImage?
    
    init(){}
}


struct CellConfigurator<M> {
    let titleKeyPath: KeyPath<M, String>
    let subtitleKeyPath: KeyPath<M, String>
    let imageKeyPath: KeyPath<M, UIImage?>

    func configure(cell: UITableViewCell, for model: M) {
        cell.textLabel?.text = model[keyPath: titleKeyPath]
        cell.detailTextLabel?.text = model[keyPath: subtitleKeyPath]
        cell.imageView?.image = model[keyPath: imageKeyPath]
    }
}

extension Sequence {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keyPath] }
    }
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}

class KKKeyPathObject: NSObject {
    
    let articles = [Article]()
    
    let songCellConfigurator = CellConfigurator<Article>(
        titleKeyPath: \.title,
        subtitleKeyPath: \.body,
        imageKeyPath: \.image
    )
    
    let paragraphe:CellConfigurator<Paragraph> = CellConfigurator<Paragraph>(
        titleKeyPath: \.title,
        subtitleKeyPath: \.body,
        imageKeyPath: \.image
    )
    
    func simpleKeyPath()  {
        let articleIDs = articles.map(\.title)
        let articleSources = articles.map(\.image)
        print(articleIDs,articleSources)
    }
    
    func sequenceKeyPath()  {
        let _ = articles.sorted(by: \.body)
    }
    
    func updateCellDatas()  {
    }
}
