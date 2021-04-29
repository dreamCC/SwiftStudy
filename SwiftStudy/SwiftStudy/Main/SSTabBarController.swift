//
//  SSTabBarController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/22.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import QMUIKit

class SSTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        add("first", .contacts, 0, HomeViewController.self)
        add("second", .bookmarks, 1, SecondViewController.self)
        add("third", .downloads, 2, UIViewController.self)
        add("fourth", .featured, 3, UIViewController.self)

    }
    
    func add(_ title: String,
             _ sysItem: UITabBarItem.SystemItem,
             _ tag: Int,
             _ type: UIViewController.Type) {
        let navi = SSNavigationController(rootViewController: type.init())
        navi.tabBarItem = UITabBarItem(tabBarSystemItem: sysItem, tag: tag)
        addChild(navi)
    }
 
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
}



