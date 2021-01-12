//
//  SSTabBarController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/22.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSTabBarController: UITabBarController {
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let homeVc = HomeViewController()
        let homeNavi = SSNavigationController(rootViewController: homeVc)
        
        let secondVc = UIViewController()
        let secondNavi = SSNavigationController(rootViewController: secondVc)
        
        let thirdVc = UIViewController()
        let thirdNavi = SSNavigationController(rootViewController: thirdVc)
        
        let forthVc = UIViewController()
        let forthNavi = SSNavigationController(rootViewController: forthVc)
        
        viewControllers = [homeNavi, secondNavi, thirdNavi, forthNavi]
        homeNavi.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        secondNavi.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        thirdNavi.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
        forthNavi.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 3)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
}



