//
//  FilesManagerTool.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/11.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit
import SDWebImage

let kIMAGE_PATH = "image"

let kVEDIO_PATH = "vedio"

let kFILE_PATH  = "file"


class FilesManagerTool: NSObject {
    
    var  baseURL : URL?  {//默认Document文件夹
        let path = FilesManagerTool.documentDir()
        let pathURL  = URL.init(fileURLWithPath: path)
        return pathURL
    }
    
    
    static let shareInstance = FilesManagerTool()
    private override init() {
        
    }
    
    // MARK:  Default Contents Path
    var imagePath : URL?{
       
        get{
            let path :URL  = self.baseURL!
            
            let imagePath = path.appendingPathComponent(kIMAGE_PATH)
            
            return imagePath
        }
        set{
            let path = FilesManagerTool.documentDir()
            
            var pathURL : URL? = URL.init(fileURLWithPath: path)
            
            self.createFolder(name: kIMAGE_PATH, baseUrl: &pathURL)
        }
        
    }
    
    var vedioPath : URL?{
        get{
            let path :URL  = self.baseURL!
            
            let imagePath = path.appendingPathComponent(kVEDIO_PATH)
            
            return imagePath
        }
        set{
            let path = FilesManagerTool.documentDir()
            
            var pathURL : URL? = URL.init(fileURLWithPath: path)
            
            self.createFolder(name: kVEDIO_PATH, baseUrl: &pathURL)
        }
        
        
    }
    
    var filePath : URL?{
        
        get{
            let path :URL  = self.baseURL!
            
            let imagePath = path.appendingPathComponent(kFILE_PATH)
            
            return imagePath
        }
        set{
            let path = FilesManagerTool.documentDir()
            
            var pathURL : URL? = URL.init(fileURLWithPath: path)
            
            self.createFolder(name: kFILE_PATH, baseUrl: &pathURL)
        }
    }
    
    class func imageWithNames(imageName:String) -> UIImage {
        if imageName.isEmpty {
            return UIImage();
        }
        
        var name = imageName
        if name.hasSuffix("gif") {
            let image_name = name.split(separator: ".").first
            let image_name_string = image_name?.decomposedStringWithCompatibilityMapping
            let image_content_path = Bundle.main.path(forResource: image_name_string, ofType: "gif")
            let image_url = NSURL.fileURL(withPath: image_content_path!)
            let image_data = try? Data.init(contentsOf: image_url, options: Data.ReadingOptions.mappedIfSafe)
            let image:UIImage? = UIImage.sd_animatedGIF(with: image_data)
            return image!
        }
        else{
            if UIDevice().retina > 2.0  {
                name  = imageName + "@3x.png"
            }
            else{
                name  = imageName + "@2x.png"
            }
            var image:UIImage? = UIImage(named: name);
            
            if image == nil {// 非2x、3x图片
                image = UIImage(named: imageName)
            }
            
            image = image?.withRenderingMode(.alwaysOriginal);
            return image!;
        }
    }
    
    class func imageWithNames(imageName:String,needOffen:Bool) -> UIImage {
        if needOffen {
            return self.imageWithNames(imageName: imageName)
        }
        else{
            var name = imageName
            if UIDevice().retina > 2.0  {
                name  = imageName + "@3x.png"
            }
            else{
                name  = imageName + "@2x.png"
            }
            let bundle = Bundle.main.path(forResource: name, ofType: nil)
            var image = UIImage(contentsOfFile: bundle!)
            image = image?.withRenderingMode(.alwaysOriginal)
            if image == nil {// 非2x、3x图片
                image = UIImage(named: imageName)
            }
            
            return image!
        }
    }
    // MARK: Contents Path
    
    /// 获取应用程序目录
    ///
    /// - Returns: 返回应用程序目录
    class func homeDir() -> String {

        return NSHomeDirectory()
        
    }
    
    /// 获取应用文档目录
    ///
    /// - Returns: 返回应用文档目录
    class func documentDir() -> String {
        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                                FileManager.SearchPathDomainMask.userDomainMask, true)
        let documnetPath = documentPaths[0]

        return documnetPath
    }
    
    /// 获取应用库目录路径
    ///
    /// - Returns: 返回应用库目录路径
    class func libraryDir() -> String {
        //Library目录－方法1
        let libraryPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,
                                                               FileManager.SearchPathDomainMask.userDomainMask, true)
        let libraryPath = libraryPaths[0] 

        return libraryPath
    }
    
    /// 获取应用缓存路径
    ///
    /// - Returns: 返回应用缓存路径
    class func cacheDir() -> String {
        //Cache目录－方法1
        let cachePaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,
                                                             FileManager.SearchPathDomainMask.userDomainMask, true)
        let cachePath = cachePaths[0]

        return cachePath
    }
    
    /// 获取应用临时目录路径
    ///
    /// - Returns: 返回应用临时目录路径
    class func templeDir() -> String {
        //方法1
        let tmpDir = NSTemporaryDirectory()
        
        return tmpDir
    }

    
    /// 获取bundle 路径 工程打包安装后会在NSBundle.mainBundle()路径下，该路径是只读的，不允许修改。
    ///
    /// - Returns: 返回获取bundle 路径
    class func bundelDir(path:String,type:String) -> String {
        let bundleDBPath:String? = Bundle.main.path(forResource: path, ofType: type)
        return bundleDBPath!
    }
    
    // MARK:  Create File
    /// 创建文件夹
    ///
    /// - Parameters:
    ///   - name: 文件夹名字
    ///   - baseUrl: 父目录路径
    func createFolder(name:String, baseUrl:inout URL?){
        if baseUrl == nil {
            baseUrl = self.baseURL
        }
        let manager = FileManager.default
        let folder = self.baseURL?.appendingPathComponent(name, isDirectory: true)
        print("新建文件夹: \(String(describing: folder))")
        let exist = manager.fileExists(atPath: folder!.path)
        if !exist {
            if ((folder?.scheme) != nil) {
                try! manager.createDirectory(at: folder!, withIntermediateDirectories: true,
                                             attributes: nil)
            }
            else{
                debugPrint(folder ?? "scheme 不对")
                let  folder = URL.init(fileURLWithPath:  (folder?.absoluteString)!)
                try! manager.createDirectory(at: folder, withIntermediateDirectories: true,
                                             attributes: nil)
            }
        }
    }
    
    
    /// 创建文件
    ///
    /// - Parameters:
    ///   - name: 文件名字
    ///   - fileBaseUrl: 父路径
    ///   - data: 文件内容 Data类型
    func createFileWithData(name:String, fileBaseUrl:inout URL?, data:Data?){
        if fileBaseUrl == nil {
            fileBaseUrl = self.baseURL
        }
        
        let manager = FileManager.default
        let file = fileBaseUrl?.appendingPathComponent(name)
        print("文件: \(String(describing: file))")
        let exist = manager.fileExists(atPath: (file?.path)!)
        if !exist {
            let createSuccess = manager.createFile(atPath: (file?.path)!,contents:data,attributes:nil)
            print("文件创建结果: \(createSuccess)")
        }
        else{
            self.removeFileWithURL(url: file!)
            let createSuccess = manager.createFile(atPath: (file?.path)!,contents:data,attributes:nil)
            print("移除先前的文件，文件创建结果: \(createSuccess)")
        }
    }
    
    
    /// 创建文件
    ///
    /// - Parameters:
    ///   - name: 文件名字
    ///   - fileBaseUrl: 父路径
    ///   - content: 文件内容，string类型
    func createFileWithContent(name:String, fileBaseUrl:inout URL?, content:String?){
       let data = content?.data(using: String.Encoding.utf8, allowLossyConversion: false)
       self.createFileWithData(name: name, fileBaseUrl: &fileBaseUrl, data: data)
    }
    
    //深度遍历，会递归遍历子文件夹（包括符号链接，所以要求性能的话用enumeratorAtPath）
    func iterateFolder(url:URL) -> [NSString]? {
        let manager = FileManager.default
        let subPaths = manager.subpaths(atPath: url.path)
        return subPaths! as [NSString]
    }
    
    //深度遍历，会递归遍历子文件夹（但不会递归符号链接）
    func iterateFolder(path:URL) -> FileManager.DirectoryEnumerator? {
        let manager = FileManager.default
        let enumeratorAtPath = manager.enumerator(atPath: path.path)
        return enumeratorAtPath
    }
    
    
    /// 判断文件是否存在
    ///
    /// - Parameter path: 文件在Document目录的完整路径
    /// - Returns: 是否存在的结果
    func isFileExist(path:NSString) -> Bool {
        let fileManager = FileManager.default
        let filePath:String = FilesManagerTool.documentDir() + "/\(path)"
        print("要判断的文件 \(filePath)")
        let exist = fileManager.fileExists(atPath: filePath)
        return exist
    }
    
    
    /// 移除Document中的文件
    ///
    /// - Parameter file: 要移除的文件相对于Document的路径
    func removeFile(fileAbsoultePath:String) -> Void {
        let fileManager = FileManager.default
        let srcUrl = FilesManagerTool.documentDir() + "/\(fileAbsoultePath)"
        try! fileManager.removeItem(atPath: srcUrl)
    }
    
    
    /// 移除Document中的文件
    ///
    /// - Parameter url: 要移除的文件绝对路径URL格式
    func removeFileWithURL(url:URL) -> Void {
        let fileManager = FileManager.default
        try! fileManager.removeItem(at: url)
    }
    
    /// 移除Document的文件夹
    ///
    /// - Parameter folder: 要移除的文件夹
    func removeFolder(folder:String) -> Void {
        let  fileManager = FileManager.default
        let  myDirectory = FilesManagerTool.documentDir() + "/\(folder)"
        try! fileManager.removeItem(atPath: myDirectory)
        try! fileManager.createDirectory(atPath: myDirectory, withIntermediateDirectories: true,
                                         attributes: nil)
    }
    
    
    /// 读取文件内容
    ///
    /// - Parameter file: 要读取的文件
    /// - Returns: 文件内容 string 类型
    func contentOfFile(file:String) -> String {
        let docPath : URL = try! FilesManagerTool.documentDir().asURL()
        let file = docPath.appendingPathComponent("\(file)")
        
        let readHandler = try! FileHandle(forReadingFrom:file)
        let data = readHandler.readDataToEndOfFile()
        let readString = String(data: data, encoding: String.Encoding.utf8)
        print("文件内容: \(String(describing: readString))")
        
        return readString!
    }
    
    
    /// 获取文件属性
    ///
    /// - Parameter file: 要读取的文件
    /// - Returns: 文件属性
    func fileAttribute(file:String) -> [FileAttributeKey:Any] {
        let  fileManager = FileManager.default
        let docPath : URL = try! FilesManagerTool.documentDir().asURL()
        let file = docPath.appendingPathComponent("\(file)")
        
        let attributes = try? fileManager.attributesOfItem(atPath: file.path) //结果为Dictionary类型
        print("attributes: \(attributes!)")
        return attributes!
    }
    
}
