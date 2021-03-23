//
//  SSNSCacheViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/10/30.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit


/*
 NSCahce。
 如果我们需要内存缓存的话，使用NSCache是最好的选择。
 相比NSMutableDicitionray。NSCache是线程安全的。
 
 */


class SSNSCacheViewController: UIViewController {

    
    private let cache = NSCache<NSString, NSString>.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cache.setObject("hello", forKey: "world")
    }

}
