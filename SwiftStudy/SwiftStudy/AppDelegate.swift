//
//  AppDelegate.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/19.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit



// 相当于oc中，main函数里面调用的UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
     
        
        initTheme()
        initAppUI()
        
        return true
    }


}

