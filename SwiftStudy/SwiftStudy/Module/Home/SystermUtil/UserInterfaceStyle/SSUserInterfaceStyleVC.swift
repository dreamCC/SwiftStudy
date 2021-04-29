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
 
 默认控件是支持暗黑样式的，比如UILable，如果我们不设置颜色，那么dark样式下字体是白色，在light样式
 下字体是黑色。如果我们使用自定义颜色，则颜色不会随着设置的改变而改变。
 
对于UIView，的系统颜色属性，比如backgroudColor、tintColor，这些会随着动态颜色值的变化改变，不需要重写赋值UIView会自动刷新。
 
 当暗黑模式切换的时候，ViewWillAppear并不会改变，如果颜色设置成动态颜色，那么会走回到方法，但是并不会重新加载，目测其渲染过程是有
 苹果自己的一套规则。
 
 
 我们可以捋一捋内部关系：
 1、暗黑模式其实和userInterFaceStyle有关。
 2、userInterfaceStyle其实是通过UITraitCollection获取的。
 3、UITraitCollection其实有很多和特性有关的东西，比如字体、亮度等一些特性。
 

 */

class SSUserInterfaceStyleVC: QMUICommonViewController {

   
    
    override func initSubviews() {
        
        
        
        let redView = UIView()
        redView.backgroundColor = UIColor.red
        redView.layer.allowsGroupOpacity = false
        view.addSubview(redView)
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 5) {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0) {
                    redView.alpha = 0.5
                }
            }
        }
        
        let blueView = UIView()
        blueView.backgroundColor = UIColor.blue

        redView.addSubview(blueView)
        redView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        
        blueView.snp.makeConstraints { (make) in
             make.centerX.equalToSuperview()
             make.top.equalToSuperview().offset(100)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        
        let gridView = QMUIFloatLayoutView()
        gridView.layer.borderWidth = 1
        gridView.layer.borderColor = UIColor.qmui_color(themeProvider: { (manager, identify, theme) -> UIColor in
        
            print(type(of: theme))
            guard let theme = theme as? QDThemeProtocol else {
                return UIColor.red
            }
            
            return theme.themeBackgroundColor()
            }).cgColor
        gridView.padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        gridView.itemMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.addSubview(gridView)
        gridView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(300)
        }
        
        self.view.qmui_themeDidChangeBlock = {
            gridView.layer.borderColor = QDThemeManager.currentTheme?.themeTintColor()?.cgColor
        }
        
        let btnTitles = ["Default", "Grapefruit", "Grass", "Pink Rose", "Dark"]
        btnTitles.forEach { (value) in
            let btn = QMUIButton()
            btn.backgroundColor = UIColor.gray
            btn.setTitle(value, for: .normal)
            btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
            btn.addTarget(self, action: #selector(themeBtnClick(btn:)), for: .touchUpInside)
            gridView.addSubview(btn)
        }
        
        
        let newTrait = UITraitCollection()
        print(self.traitCollection.userInterfaceIdiom.rawValue, traitCollection.displayScale, traitCollection.displayGamut, traitCollection.forceTouchCapability.rawValue)
        print(newTrait.userInterfaceIdiom.rawValue, newTrait.displayScale, newTrait.displayGamut, newTrait.forceTouchCapability)
        
        let device = UIDevice.current
        print(device.name, device.systemName, device.systemVersion, device.identifierForVendor)
        

        print(UIApplication.shared.statusBarOrientation.rawValue, UIDevice.current.orientation.rawValue)
        
        

    }

    
    @objc func themeBtnClick(btn: QMUIButton) {
        QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier = btn.currentTitle as (NSCopying & NSObjectProtocol)?
        _ = QDThemeManager.self.currentTheme?.applyConfigurationTemplate()
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
        print("traitCollectionDidChange", traitCollection.userInterfaceStyle.rawValue )
        print("traitCollectionDidChange", traitCollection.preferredContentSizeCategory.rawValue)

    }
    
    
}

extension SSUserInterfaceStyleVC {
    
    @available(iOS 13.0, *)
    private func uitraitCollection() {
        let traitC = traitCollection
        
        // 判断当前设备
        let device = traitC.userInterfaceIdiom
        print("当前设备是-",device.rawValue)
        
        // 全局获取配置。
        let currentTrait = UITraitCollection.current
        print(currentTrait)
        // 没个控制器ViewController或者View都可以获取self.traitCollection。
        
        
    }
}
