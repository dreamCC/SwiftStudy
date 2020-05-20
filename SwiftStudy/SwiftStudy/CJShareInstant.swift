//
//  CJShareInstant.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/19.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit

class CJShareInstant: NSObject {

    /// 下面这两种写法都是，单利写法。上面这个写法，可以进行一些初始化。
    static let `default`: CJShareInstant = {
        print("初始化")
        return CJShareInstant()
    }()
    //static let `default` = CJShareInstant()
    
    private override init() {
        
        
    }
    
}



