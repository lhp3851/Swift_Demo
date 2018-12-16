//
//  KKWebViewViewController.swift
//  Swift_Demo
//
//  Created by Jerry on 2017/11/25.
//  Copyright © 2017年 Jerry. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class KKWebViewViewController: BaseViewController,WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate {

    lazy var web : WKWebView = {
        let view = WKWebView.init()
        view.uiDelegate = self
        view.navigationDelegate = self
        return view
    }()
    
    var vcTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData()
    }
    
    override func initPannel() {
        super.initPannel()
        self.view.addSubview(self.web)
        self.setConstraints()
    }
    
    
    override func initData() {
        super.initData()
        self.navigationItem.title = self.vcTitle
        let path = Bundle.main.bundlePath
        let baseURL = URL.init(fileURLWithPath: path)
        let htmlPath = Bundle.main.path(forResource: "kaquanbao", ofType: "html")
        let htmlContent = try? String.init(contentsOfFile: htmlPath!, encoding: String.Encoding.utf8)
        self.web.loadHTMLString(htmlContent!, baseURL: baseURL)
    }
    
    
    func setConstraints() -> Void {
        self.web.snp.makeConstraints { (make) in
            make.right.left.top.equalTo(0)
            make.height.equalTo(self.view.frame.size.height)
        }
    }
    
    // MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        print(webView.debugDescription,navigation.debugDescription)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
         print(webView.debugDescription,navigation.debugDescription)
   
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
         print(webView.debugDescription,navigation.debugDescription,error)
    }
    
    // MARK: - UIWebViewDelegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("webView Start Load")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("webView Finish Load")
        typealias JSHandler = (JSContext?,JSValue?) -> (Void)
        let handler : JSHandler? = {(context:JSContext?,value:JSValue?) -> Void in print("handled,ok~")}
        let context : JSContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        context.exceptionHandler = handler
        print("context:",context)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("failed load webview")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

   

}
