//
//  SSTuplesVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/5/13.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 关于元祖。
 其实就是讲不通类型聚合成元祖类型。其写法是以小括号（）进行包裹。最简单写法let tuple = （Int，String）。
 1、通过tuple.0和tuple.1来取值，这和数组还是有区别的。
 2、通过拆解成单独的变量来获取值。let (value1, value2) = tuple， 也可以拆取单个值let (_, value2) = tuple
 
 我们也可以通过给元素命名来进行赋值。let tuple2 = (age: Int, name: String)
 
 常见元祖用法。switch中对于元祖进行解包。
 
 */
class SSTuplesVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        let tuple1: (Int, String) = (12, "hello")
        
        // 通过下标取值
        print(tuple1.0, tuple1.1)
        
        // 通过拆包取值
        let (value1, value2) = tuple1
        print(value1, value2)
        
        // 拆取单个值
        let (_, valueOnly) = (12, "hell")
        print(valueOnly)
        
        // 通过给元素赋值，来进行命名
        let tuple2 = (age: 12, name: "lucy")
        print(tuple2.age, tuple2.name)
        
        // 拆值
        let (a, n) = tuple2
        print(a, n)
        
        
        switch tuple1 {
        case let (a, b):
            print(a, b)
        }
        
        
      
    }
}
