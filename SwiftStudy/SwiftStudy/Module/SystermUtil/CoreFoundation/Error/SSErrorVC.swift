//
//  SSErrorVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/14.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 Error在 swift中其实是一个协议。
 Error衍生出的协议，LocalizedError、CustomNSError。
 关于Error的使用，最为经典的是AFError的设计思路。
 */
class SSErrorVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        titleName = "Error"
     
        let error = SSBaseError.errorOne
        
        print(error.localizedDescription, error.errorCode, error.failureReason ?? "")
        
        let matchError = MachError(MachErrorCode.failure, userInfo: ["key":"----"])
        print(matchError)
    }

    
}


enum SSBaseError: Error {
    case errorOne
    case errorTwo
    
    var localizedDescription: String {
        switch self {
        case .errorOne:
            return "这是错误-1"
        default:
            return "这是错误-2"
        }
    }
}

extension SSBaseError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .errorOne:
            print("这是错误-1")
        default:
            print("这是错误-2")
        }
        return ""
    }
    
    var failureReason: String? {
        switch self {
        case .errorOne:
            print("可能是因为没有初始化")
        default:
            print("对象不能为空")
        }
        return ""
    }

}

extension SSBaseError: CustomNSError {
    
    var errorCode: Int {
        switch self {
        case .errorOne:
            return 100
        default:
            return -99
        }
    }
    
    var errorUserInfo: [String : Any] {
        
        return [NSLocalizedDescriptionKey:"xxxx"]
    }
}

