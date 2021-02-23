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

 需要理解ios 13，xcode 11引入的SceneDelegate。
 ios 13之前，AppDelegate控制着app的生命周期、以及app页面的生命周期。
 ios 13之后，AppDelegate只控制app的生命周期，UI的生命周期交给Scene session来控制。
 xcode 11之后，创建项目，AppDelegate里面会有两个和Scene Session有关的两个方法
 configurationForConnectingSceneSession： 生成一个UISceneConfig，其内部会生成一个UISceneSession。 并且每个
 window.windowScene必须不能为空。不然window会显示不出来。  这些配置在info.plist上体现Application Scene manifest字段。
 
 具体加载过程：
 1、app启动调用Appdelegate中，appDidFinishLaunch方法表示app加载完成。
 2、查看info.plist中是否有Application Scene manifest以及是否Scene Config及配置是否正确，如果正确就按plist上面加载，如果不正确会
    调用AppDelegate中生成UISceneConfig的代理。
 3、通过UISceneConfig来生成UISceneSession，同时同构UISceneConfig来获取UIWindowSceneDelegate，通过在代理方法中设置window.windoScene。
 
 
 */



class SSUIWindowSceneViewController: SSBaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            
    }
}




class Outter {
    let age: Int = 20
    
    class Inner {
        
        func testMethod() {
            
            
        }
    }
}
