//
//  KKExceptionTool.swift
//  Swift_Demo
//
//  Created by sumian on 2019/3/28.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

//MARK: - 触发信号后操作
func SignalExceptionHandler(signal:Int32) -> Void
{
    var mstr = String()
    mstr += "Stack:\n"
    //增加偏移量地址
    mstr = mstr.appendingFormat("slideAdress:0x%0x\r\n", calculateAddress())
    //增加错误信息
    for symbol in Thread.callStackSymbols {
        mstr = mstr.appendingFormat("%@\r\n", symbol)
    }
    CrashManager.saveCrash(appendPathStr: .signalCrashPath, exceptionInfo: mstr)
    exit(signal)
}

func registSignalHandler() {
    signal(SIGABRT) {  (sig) in
        SignalExceptionHandler(signal: sig)
    }
    signal(SIGSEGV) { (sig) in
       SignalExceptionHandler(signal: sig)
    }
    signal(SIGBUS) { (sig) in
        SignalExceptionHandler(signal: sig)
    }
    signal(SIGTRAP) { (sig) in
        SignalExceptionHandler(signal: sig)
    }
    signal(SIGILL) { (sig) in
        SignalExceptionHandler(signal: sig)
    }
}

func unregisterSignalHandler()
{
    signal(SIGINT, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGTRAP, SIG_DFL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
}


func registerUncaughtExceptionHandler()
{
    NSSetUncaughtExceptionHandler(UncaughtExceptionHandler)
}

func UncaughtExceptionHandler(exception: NSException) {
    
    let arr = exception.callStackSymbols
    let reason = exception.reason
    let name = exception.name.rawValue
    var crash = String()
    crash += "Stack:\n"
    crash = crash.appendingFormat("slideAdress:0x%0x\r\n", calculateAddress())
    crash += "\r\n\r\n name:\(name) \r\n reason:\(String(describing: reason)) \r\n \(arr.joined(separator: "\r\n")) \r\n\r\n"
    CrashManager.saveCrash(appendPathStr: .nsExceptionCrashPath, exceptionInfo: crash)
    
}
