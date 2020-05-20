//
//  SSUserInterfaceStyleVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/4/26.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 暗黑模式，是ios 13推出的一种现实模式。而所谓的暗黑模式，其实就是我们可以改变系统的分格为dark。
 
 默认控件是不支持暗黑样式的，比如UILable，如果我们不设置颜色，那么dark样式下字体是白色，在light样式
 下字体是黑色。如果我们使用自定义颜色，则颜色不会随着设置的改变而改变。
 
 
 */
class SSUserInterfaceStyleVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        titleName   = "暗黑模式"
        desLab.text = "这是暗黑模式的测试代码"
        view.backgroundColor = UIColor.purple
        //openOrCloseUserInterface()
        adaptUserInterfaceStyle()
    }
   

}

extension SSUserInterfaceStyleVC {
    
    private func openOrCloseUserInterface() {
        
        // 这个是单个页面的打开或者关闭。但是仅ios13之后才能使用。
        // 我们也可以在info.plist文件里面进行对整个项目的配置。
        // 增加User Interface Style这段， value = Light
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        } else {
            
        }
    }
    
    // 适配暗黑模式
    private func adaptUserInterfaceStyle() {
        // 1、苹果提供了一套动态颜色。如UIColor.systermxxx获取的颜色。
        desLab.textColor = UIColor.systemBlue
        
        // 2、通过判断当前的样式来进行切换。
        print("当前的样式-",traitCollection.userInterfaceStyle.rawValue)
        
        // 3、苹果还提供了一套语义化颜色。比如UIColor.systemBackground、UIColor.lable、
        // UIColor.seperateColor、UIColor.systemFill等颜色。
        
        // 4、可以创建动态颜色。通过不同模式返回不同的颜色。
        if #available(iOS 13.0, *) {
            let dyColor = UIColor { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.darkGray
                }else {
                    return UIColor.lightGray
                }
            }
            
            print(dyColor)
        } else {
            
        }
    
    
        // 5、通过方法监听。如果模式切换，会进入traitCollectionDidChange方法中。
    }
    
    // 通过方法监听
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        print("traitCollectionDidChange", previousTraitCollection?.userInterfaceStyle.rawValue ?? "null")
    }
}

extension SSUserInterfaceStyleVC {
    
    private func uitraitCollection() {
        let traitC = traitCollection
        
        // 判断当前设备
        let device = traitC.userInterfaceIdiom
        print("当前设备是-",device.rawValue)
        
        //
        
    }
}
