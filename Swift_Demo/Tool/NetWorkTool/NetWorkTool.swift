//
//  NetWorkTool.swift
//  ZhaoCaiMao_Swift
//
//  Created by 刘合鹏 on 2017/9/13.
//  Copyright © 2017年 TMWL. All rights reserved.
//

import UIKit
import Alamofire

let kTIME_OUT_OF_REQUEST = 15 //超时时间
let kURL_DOMAIN          = "http://s.zhaocaichina.com"


class NetWorkTool: NSObject {
    
    typealias SuccessClosure = (Any?) -> ()
    typealias FailureClosure = (Any?) -> ()
    typealias RequestTask = Request
    
    var sessionManager = SessionManager.default
    var defaultConfigration :URLSessionConfiguration?
    
    static let shareInstance = NetWorkTool()
    private override init() {
        super .init()
        setSessionManagerDefaultConfigration()
    }
    
    /// 设置默认请求参数的配置
    func setSessionManagerDefaultConfigration() -> Void {
        defaultConfigration = sessionManager.session.configuration
        
        defaultConfigration?.timeoutIntervalForRequest = TimeInterval(kTIME_OUT_OF_REQUEST);//默认请求超时时间
        
        defaultConfigration?.requestCachePolicy = .useProtocolCachePolicy //默认缓存策略
        
        defaultConfigration?.httpCookieStorage = HTTPCookieStorage.shared //默认cookie
    }
    
    /// 设置cookie
    func setCookies(cookies:[HTTPCookie]?,url:URL , mainDocumentURL:URL) -> Void {
        let defualtCookies = defaultConfigration?.httpCookieStorage
        
        defualtCookies?.setCookies(cookies!, for: url, mainDocumentURL: mainDocumentURL)
    }
    
    func setCachePolicy(policy:NSURLRequest.CachePolicy) -> Void {
        defaultConfigration?.requestCachePolicy = policy
    }

    
    /// 设置请求头部信息
    ///
    /// - Parameter header: 要设置的请求头部信息
    func setHeader(header:[String:String]) -> Void {
        let defaultHeader :NSDictionary = SessionManager.defaultHTTPHeaders as NSDictionary
        for (key,value) in header {
            defaultHeader.setValue(value, forKey: key)
        }
    }
    
    /// 默认需要登录的接口，设置登录态
    ///
    /// - Parameter parameters: 除了登录参数之外的接口参数
    func setLoginStatus(parameters:NSMutableDictionary) -> Void {
        parameters .setValue("user.name", forKey: "jack")
    }
    
    
    /// ATS 安全认证 for HTTPS 协议
    func authenticate() -> Void {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            kURL_DOMAIN: .pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: true,
                validateHost: true
            ),
            "insecure.expired-apis.com": .disableEvaluation,
            "https://httpbin.org":.pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: true,
                validateHost: true
            ),
        ]
        
         sessionManager = SessionManager(
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }
    
    
    /// 检查网络可达性
    ///
    /// - Returns: 可达性
    func checkNetWork() -> Bool {
        return BaseRequest().isReachabile()
    }
    
    
    /// 没有网络则不发送请求、取消请求
    func stopRequestWithOutNetWork() -> Void {
        print("网络不可用")
                
    }
    
    /// 设置单个请求的配置
    ///
    /// - Parameters:
    ///   - url: 接口
    ///   - parameters: 接口参数
    ///   - loginStatus: 是否需要登录态
    ///   - cookies: 是否需要cookie
    ///   - cachePolicy: 缓存策略
    func setRequestConfig(url:URLConvertible,
                          parameters:NSMutableDictionary,
                          loginStatus:Bool,
                          cookies:Bool,
                          cachePolicy:NSURLRequest.CachePolicy?) -> Void {
        let requestURL = URL.init(string: url as! String)
        
        if loginStatus {
            if AccountModel.shareInstance.session != nil {
                self.setLoginStatus(parameters: parameters)
            }
            else{
                self.login()
            }
        }
        
        if let policy = cachePolicy {
            self.setCachePolicy(policy: policy)
        }
        
        if cookies {
            let cookies = HTTPCookie(properties: [
                HTTPCookiePropertyKey.name:"username",
                HTTPCookiePropertyKey.value:"devonios.com",
                HTTPCookiePropertyKey.path:"/",
                HTTPCookiePropertyKey.domain:"http://devonios.com"])
            
            let cookie = [cookies]
            self.setCookies(cookies: cookie as? [HTTPCookie], url: requestURL!, mainDocumentURL: requestURL!)
        }
        
    }
    
    // MARK: HTTP 发起的请求
    func getByHTTP(url:URLConvertible,
             parameters:NSMutableDictionary,
             loginStatus:Bool,
             cookies:Bool,
        cachePolicy:NSURLRequest.CachePolicy?) -> DataRequest {
        
        if !self.checkNetWork() {
            self.stopRequestWithOutNetWork()
            return sessionManager.request("")
        }
        else{
            self.setRequestConfig(url: url, parameters: parameters, loginStatus: loginStatus, cookies: cookies, cachePolicy: cachePolicy)
            return sessionManager.request(url,
                                          method:HTTPMethod.get,
                                          parameters: parameters as? Parameters,
                                          encoding: URLEncoding.methodDependent,
                                          headers: nil)
        }
    }
    
    
    // MARK: HTTP 发起的请求
    func postByHTTP(url:URLConvertible,
                   parameters:NSMutableDictionary,
                   loginStatus:Bool,
                   cookies:Bool,
                   cachePolicy:NSURLRequest.CachePolicy?) -> DataRequest {
        
        if !self.checkNetWork() {
            self.stopRequestWithOutNetWork()
            return sessionManager.request("")
        }
        else{
            
            self.setRequestConfig(url: url, parameters: parameters, loginStatus: loginStatus, cookies: cookies, cachePolicy: cachePolicy)
            self.authenticate()
            return sessionManager.request(url,
                                          method:HTTPMethod.post,
                                          parameters: parameters as? Parameters,
                                          encoding: URLEncoding.httpBody,
                                          headers: nil)
        }
    }
    
    
    
    func login() -> Void {
        let sourceVC = UIWindow.topViewController() as! BaseViewController
        let destinationVC = AccountViewController()
        destinationVC.view.backgroundColor = kCOLOR_CLEAR
        sourceVC.present(destinationVC, animated: true) {
            
        }
    }
    
    
    // MARK: HTTPS 发起的请求
}














