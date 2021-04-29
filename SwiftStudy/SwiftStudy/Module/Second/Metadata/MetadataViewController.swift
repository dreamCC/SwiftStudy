//
//  MetadataViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/4/20.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit
import KakaJSON

class Person<T> {
    var name: String = ""
    var age: Int     = 0
}

class MetadataViewController: UIViewController {

    
    // 创建view，如果重写可以自定义。也就是不调用super.loadView
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let metadata = Metadata.type(Person<Int>.self)
        print(metadata)
        
        
       
    }

}
