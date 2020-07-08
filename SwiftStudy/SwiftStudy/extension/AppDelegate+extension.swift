//
//  AppDelegate+extension.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/22.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import Foundation
import UIKit

/*
 关于QMUITheme的实现方式。
 我们需要知道的是QMUICore中重要的几个类， QMUIConfiguration、和QMUIConfigurationMacros
 QMUIConfiguration维护这app中各种所需属性的配置表。
 QMUIConfigurationMacros里面是获取配置表中的属性。
 
 如果想新增一张配置表，那么只需要遵循QMUIConfigurationTemplateProtocol协议，在该协议中，通过 QMUICMI.xxx来改变QMUIConfiguration的属性。 至于需要哪个配置表生效，只需要重写-shouldApplyTemplateAutomatically
     即可。
 
 
 然后看QMUITheme代码：
 QMUIThemeManager管理着app的全部主题，注意app启动的时候，需要注册不同的主题（调用themeGeneral 通过不同的identify生成不同的Theme表单。）。
 QMUIThemeCenter管理者QMUIThemeManager，从此可以生成多维度主题。
 最重要的主题就是QMUIThemeProvider类，用户控制着主题的样式。
 UIColor、UIView、UIImage、UIViewController和UIVisualEffect几个分类，这几个分类能够监听到主题变化的时候的方法变化。
 
 */
extension AppDelegate {
    
    func initAppUI() {
        
        let tab = SSTabBarController()

        window?.backgroundColor = UIColor.white
        window?.rootViewController = tab
        window?.makeKeyAndVisible()
    }
    
    func initTheme() {
        
       
        
        // 监听主题变化
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleThemeChange(notify:)),
                                               name: .QMUIThemeDidChange,
                                               object: nil)
        
        //let btnTitles = ["Default", "Grapefruit", "Grass", "Pink Rose", "Dark"]
        QMUIThemeManagerCenter.defaultThemeManager.themeGenerator = {(identify: (NSCopying & NSObjectProtocol)?)-> NSObject? in
            
            guard let themeId = identify as? String else {
                return QMUIConfigurationTemplate()
            }
            if themeId == "Default" {
                return QMUIConfigurationTemplate()
            }else if themeId == "Grapefruit" {
                return QMUIConfigurationTemplateGrapefruit()
            }else if themeId == "Grass" {
                return QMUIConfigurationTemplateGrass()
            }else if themeId == "Pink Rose" {
                return QMUIConfigurationTemplatePinkRose()
            }else if themeId == "Dark" {
                return QMUIConfigurationTemplateDark()
            }
            return QMUIConfigurationTemplate()
        }
    }
    
    
}


// MAKR: 主题变化
extension AppDelegate {
    
    @objc func handleThemeChange(notify: Notification) {
        guard let currentTheme: QMUIThemeManager = notify.object as? QMUIThemeManager else {
            return
        }
        UserDefaults.standard.setValue(currentTheme.currentThemeIdentifier,
                                       forKey: "selectedThemeIdentifier")
    }
}
