//
//  SSIntViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import JavaScriptCore

class SSIntViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        titleName = "Int"
        
        desLab.text = "Swift中Int是一个结构体。 常见的Int有，Int、Int8、Int16、Int32、Int64，其表示的位数。"
        
        print("Int取值：",Int.max, Int.min)
        print("Int8取值：",Int8.max, Int8.min)
        print("Int16取值：", Int16.max, Int16.min)
        print("Int32取值：", Int32.max, Int32.min)
        print("Int64取值：", Int64.max, Int64.min)
        
        /*
         输出结果：所以Int是根据当前操作系统的位数来进行显示取值。 Int 8个字节。 Int8 一个字节。Int16 两个字节。 Int32 4个字节。 Int64 8个字节。
         Int取值： 9223372036854775807 -9223372036854775808
         Int8取值： 127 -128
         Int16取值： 32767 -32768
         Int32取值： 2147483647 -2147483648
         Int64取值： 9223372036854775807 -9223372036854775808
         
         */
        
        
    }
    

  
    

}
