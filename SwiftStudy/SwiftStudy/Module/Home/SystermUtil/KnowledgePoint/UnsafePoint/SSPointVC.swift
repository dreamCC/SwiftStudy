//
//  SSPointVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/13.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSPointVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func memolayout(_ sender: UIButton) {
        
        // MemoLayout能确定一个类型，占内存大小size，对其方式aligment，和实际大小stride
        print("Int",MemoryLayout<Int>.size, MemoryLayout<Int>.alignment, MemoryLayout<Int>.stride)
        print("Double",MemoryLayout<Double>.size, MemoryLayout<Int>.alignment, MemoryLayout<Int>.stride)
        print("String",MemoryLayout<String>.size, MemoryLayout<Int>.alignment, MemoryLayout<Int>.stride)
        print("Character",MemoryLayout<Character>.size, MemoryLayout<Int>.alignment, MemoryLayout<Int>.stride)
        print("UIViewController",MemoryLayout<UIViewController>.size, MemoryLayout<Int>.alignment, MemoryLayout<Int>.stride)
        
    }
    
    
    
    @IBAction func unsafePointClick(_ sender: UIButton) {
        /*
         UnsafePointer 指针类型。 一旦我们操作内存，编译器不会对这种操作进行检测。所以我们就需要对我们的代码负责。
         默认swift是内存安全的，也不提倡我们去操作内存。 在runtime中，进程会用到UnsafePointer类型，主要是因为runtime内部
         都是结构体指针。
         
         打印地址的方式。String(format: "%p", self) 或者 NSString格式化打印。
         
     通过指针类型的名称，我们可以知道这是一个什么类型的指针：可变/不可变、原生（raw）/有类型、是否是缓冲类型（buffer），大致有以下8种类型：
         */
        
    }
    
}
