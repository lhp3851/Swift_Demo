//
//  ProfileModle.swift
//  Swift_Demo
//
//  Created by lhp3851 on 2017/10/17.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit

class ProfileModle: NSObject {

    var imageName = String()
    var sbuTitle = String()
    
    
    static let pannelModdel :[[[String:String]]] =
        [[["imageName00":"subTitle00"],["imageName01":"subTitle01"],["imageName02":"subTitle02"]],
         
         [["imageName10":"subTitle10"],["imageName11":"subTitle11"],["imageName12":"subTitle12"]],
         
         [["imageName20":"subTitle20"],["imageName21":"subTitle21"],["imageName22":"subTitle22"]]]
    
    class func getModelFromDatas() -> [[ProfileModle]] {
        var modlesArray = Array<[ProfileModle]>()
        let datas = ProfileModle.pannelModdel
        for firstArray in datas {
            let secondArray = firstArray
            var subModleArrry = Array<ProfileModle>()
            for dic in secondArray {
                let subDic = dic
                let model = ProfileModle()
                model.imageName = subDic.keys.first!
                model.sbuTitle = subDic[model.imageName]!
                subModleArrry.append(model)
            }
            modlesArray.append(subModleArrry)
        }
        return modlesArray
    }
    
}
