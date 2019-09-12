//
//  Images.swift
//  Swift_Demo
//
//  Created by sumian on 2019/7/5.
//  Copyright © 2019 Jerry. All rights reserved.
//

/** 图片使用注意事项：
    1、图片加入工程前使用相关软件做无损压缩；
    2、尽量使用不带缓存的方法加载图片；
    3、工程打包的时候，去除未使用的图片以减少包大小；
    4、图片质量：100k以内的多使用PNG，大于的使用PNG；JPG、WEBP适合网络传输，酌情考虑；腾讯推出的TPG，后续可以考虑；
    5、GIF 图片的性能与效果处理参考：https://blog.ibireme.com/2015/11/02/mobile_image_benchmark/#more-41834
*/

import UIKit
import Kingfisher

extension UIImage {
    
    /** 图片格式
     1、Kingfisher 支持：PNG、JPG、GIF
     2、SDWebImage 支持：PNG、JPG、GIF、WEBP、TIFF、HEIF、HEIC
     date：2019-07-05
    **/
    enum Types:String {
        case PNG    = ".png"
        case JPG    = ".jpg"
        case GIF    = ".gif"
        case TIFF   = ".tiff"
        case WEBP   = ".webp"
    }
    
    static var `default`:UIImage {
        let temp = UIImage.imageWithColor(color: UIColor.hex(0xffffff))
        return temp
    }
    
    class func ryname(_ name:String,ext:Types = .PNG) -> UIImage {
        if name.isEmpty {
            return UIImage.default
        }
        
        if case ext = Types.GIF {
            let image_name_string = name.decomposedStringWithCompatibilityMapping
            if let image_content_path = Bundle.main.path(forResource: image_name_string, ofType: "gif") {
                let image_url = NSURL.fileURL(withPath: image_content_path)
                let image_data = try? Data.init(contentsOf: image_url, options: Data.ReadingOptions.mappedIfSafe)
                if let img = UIImage.sd_image(withGIFData: image_data) {
                    return img
                } else {
                    return UIImage.default
                }
            } else {
                return UIImage.default
            }
        } else if case ext = Types.PNG {
            let image:UIImage? = UIImage(named: name);
            
            if let img = image?.withRenderingMode(.alwaysOriginal) {
                return img
            } else {
                return UIImage.default
            }
        } else {// 其他图片，如jpg图片等
            let imageName = name + ext.rawValue
            if let  image = UIImage(named: imageName){
                return image
            } else {
                return UIImage.default
            }
        }
    }
    
    class func ryname(_ name:String,cache:Bool = false) -> UIImage {
        if cache {
            return self.ryname(name, ext: .PNG)
        } else {
            if let bundle = Bundle.main.path(forResource: name, ofType: nil){
                let image = UIImage(contentsOfFile: bundle)
                if let img = image?.withRenderingMode(.alwaysOriginal) {
                    return img
                } else if let img = UIImage(named: name) {
                    return img
                } else {
                    return UIImage.default
                }
            }
            else{
                return UIImage.default
            }
        }
    }
    
    class func named(_ imageName:String,cache:Bool = false) -> (UIImage) {
        let image = ryname(imageName, ext: UIImage.Types.PNG)
        return image
    }
    
}

