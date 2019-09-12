//
//  KKOptimizeTool.swift
//  Swift_Demo
//
//  Created by sumian on 2019/7/16.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit
import Matrix

class KKOptimizeTool: NSObject {

    static let shared = KKOptimizeTool()
    
    private override init() {}
    
    lazy var matrix:Matrix = {
        if let temp = Matrix.sharedInstance() as? Matrix {
            return temp
        } else {
            return Matrix()
        }
    }()
    
    func install() -> KKOptimizeTool {
        let builder = MatrixBuilder()
        builder.pluginListener = self
        
        let crashBlockPlugin = WCCrashBlockMonitorPlugin()
        builder.add(crashBlockPlugin)
        
        let memoryPlugin = WCMemoryStatPlugin()
        builder.add(memoryPlugin)
        
        matrix.add(builder)
        return self
    }
    
    func start()  {
        matrix.startPlugins()
    }
    
    func stop()  {
        matrix.stopPlugins()
    }
    
    
    /// 需要通过拓展MatrixBuilder 卸载
    func unInstall()  {
        
    }
}

extension KKOptimizeTool:MatrixPluginListenerDelegate {
    
    func onInit(_ plugin: MatrixPluginProtocol!) {
        print("plugin init:",plugin.debugDescription)
    }
    
    func onStart(_ plugin: MatrixPluginProtocol!) {
        print("plugin start:",plugin.debugDescription)
    }
    
    func onStop(_ plugin: MatrixPluginProtocol!) {
        print("plugin stop:",plugin.debugDescription)
    }
    
    func onDestroy(_ plugin: MatrixPluginProtocol!) {
        print("plugin destroy:",plugin.debugDescription)
    }
    
    func onReport(_ issue: MatrixIssue!) {
        print("report issue:",issue)
    }
    
}
