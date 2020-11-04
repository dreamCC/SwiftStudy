//
//  SSUIWindowSceneViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/3.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 因为iOS13的生命周期发生了改动,大家都知道,应用生命周期这个东西,一直到目前的iOS 12这个版本都是在AppDelegate里头(也就是UIApplicationDelegate里面)，但是ios13版本包括之后，AppDelegate(UIApplicationDelegate)控制生命周期的行为交给了SceneDelegate(UIWindowSceneDelegate)

 
 */

class SSUIWindowSceneViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let windows = UIApplication.shared.windows
        print(windows)
        
        let keyWindow = UIApplication.shared.keyWindow
        print(keyWindow)

        if #available(iOS 13.0, *) {
            let windowScene = keyWindow!.windowScene
            print(windowScene)
        } else {

        }
    }
}
