//
//  SSSequenceViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/30.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 Sequence队列。其实内部有一个Iterator迭代器。可以实现迭代，也就是可以遍历的。
 
 
 
 */
class SSSequenceViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let a = 200 ..< 300
        for item in a {
            print(item)
        }
        
        
        
        let b = [1, 2, 3, 4]
        for item in b {
            print(item)
        }
        
        for (item, index) in b.enumerated() {
            print(item, index)
        }
    
    }
    
 
}
