//
//  CJLog.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/8.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import QMUIKit


func dPrint(msg: String, file: String = #file, line: Int = #line, funcs: String = #function)  {
    
    let logItem: QMUILogItem = QMUILogItem()
    logItem.level = .default
    logItem.logString = msg
    logItem.name  = "defalut"
    QMUILogger.sharedInstance().printLog(
        withFile: file,
        line: Int32(line),
        func: funcs,
        logItem: logItem)
    

    
}

func iPrint(msg: String)  {
    
    let logItem: QMUILogItem = QMUILogItem()
    logItem.level = .info
    logItem.logString = msg
    logItem.name  = "info"
    QMUILogger.sharedInstance().printLog(
        withFile: #file,
        line: #line,
        func: #function,
        logItem: logItem)
    
}

func wPrint(msg: String)  {
    
    let logItem: QMUILogItem = QMUILogItem()
    logItem.level = .warn
    logItem.logString = msg
    logItem.name  = "warning"
    QMUILogger.sharedInstance().printLog(
        withFile: #file,
        line: #line,
        func: #function,
        logItem: logItem)
    
}
