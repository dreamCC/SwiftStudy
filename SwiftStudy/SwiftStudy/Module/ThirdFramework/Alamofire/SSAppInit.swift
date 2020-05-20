//
//  SSAppInit.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/5/17.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 swift构造方法，必须满足四种条件：
 1、对于子类特有的属性值，必须在父类初始化完成前进行赋值。也就是说必须要明确的确定了所有的存储属性的前提下，才能初始化成功。
 2、继承父类的属性，必须要在父类初始化完成后在进行赋值。不然会被父类初始化覆盖。
 3、convenience必须要先调用design初始化方法。必然会被design初始化的时候值覆盖。
 4、在第一阶段完成前不能调用实例方法，不能读取属性值，不能引用self
 */
class SSAppInit {
    
    static let `default` = SSAppInit()
    
    let operationQueue: OperationQueue

    private  init() {
        self.operationQueue = {
            let operationQueue = OperationQueue()
            operationQueue.maxConcurrentOperationCount = 1
            operationQueue.isSuspended = true
            return operationQueue
        }()
    }
}


