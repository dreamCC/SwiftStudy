//
//  SSWindowViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/30.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import AVFoundation

/*
 
 App中任何一个view, 只有添加到相应的window中, 才能显示出来;
 触摸事件会被传递到触摸区域内的最上层的window, 非触摸事件会被传递到keyWindow (详见后文), 并由window将事件分发给恰当的view.
 也就是只有keyWindow才能接受非触摸事件，键盘的输入的接收，如果window上面有UITextField，那么window必须是keyWindow才能输入。
 
 关于UIWindow：
 1、UIWindow继承UIView。
 2、UIWindow上面显示其他view的方式有两种，addView或者window.rootViewController = xx，通过设置rootViewController
    内部会将rootViewController.view 添加到UIwindow上面。 当然真正的层级关系是：
    UIWindow->UITransitionView->UIDropShadowView->ViewController和View，其中UITransitionView和UIDropShadowView是透明的。
 
window的隐藏，直接调用hidden = YES。即可，如果是keyWindow.hidden = YES 那么该window将会被取消keyWindow资格。
 
我们常见的Window，statusBar和alter。 这些和windowLevel有关，其优先级：
UIWindow.Level.normal = 0、 UIWindow.Level.statusBar = 1000、UIWindow.Level.alter = 2000
 
UIWindow初始化后，默认hidden = true，其显示与否也就是和hidden属性有关，我们直接window.hidden = false 就能显示该window
，当我们创建完window后，该window就会存放在UIApplication.share.windows数组中。
 
注意Window的frame是可以灵活设计的，可以使用window实现悬浮球的效果。
 
注意如果Window.frame = UIScreen.main.bounds 那么该window将会截取所有的点击事件，而且事件无法传递给其他window（后面的window）。主要是因为，该window并不是在view的层级结构中的。
 
 */
class SSViewShowWayController: QMUICommonViewController {

    
    private var prevWindow: UIWindow!
    private var currentWindow: SSWindow!
    private var popContainer: QMUIPopupContainerView!
    
    
    override func initSubviews() {

        
        
        
        
        let windowShow = QMUIButton()
        windowShow.setTitle("WindowShow", for: .normal)
        windowShow.addTarget(self, action: #selector(windowShowBtnClick), for: .touchUpInside)
        view.addSubview(windowShow)
        windowShow.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        let subVShow = QMUIButton()
        subVShow.setTitle("AddSubView", for: .normal)
        subVShow.addTarget(self, action: #selector(subShowBtnClick), for: .touchUpInside)
        view.addSubview(subVShow)
        subVShow.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(windowShow.snp.bottom).offset(20)
        }
        
        popContainer = QMUIPopupContainerView()
        popContainer.textLabel.text = "QMUIPopupContainerView"
        popContainer.sourceView = subVShow
        popContainer.isHidden = true
        self.view.addSubview(popContainer)
        
        let modalShow = QMUIButton()
        modalShow.setTitle("ModalShow", for: .normal)
        modalShow.addTarget(self, action: #selector(modalShowBtnClick), for: .touchUpInside)
        view.addSubview(modalShow)
        modalShow.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(subVShow.snp.bottom).offset(20)
        }
        
    
    }

}


extension SSViewShowWayController {
    
    @objc func windowShowBtnClick() {
        if currentWindow == nil {
            currentWindow = SSWindow()
            //currentWindow.frame = CGRect(x: 10, y: 200, width: 300, height: 200)
            currentWindow.frame = UIScreen.main.bounds
            currentWindow.backgroundColor = UIColor.clear
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapWindow))
            currentWindow.addGestureRecognizer(tapGesture)
            
            let showVc =  SSViewShowWayController()
            showVc.view.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            //currentWindow.rootViewController = showVc

            let textF = QMUITextField()
            textF.backgroundColor = UIColor.red
            textF.placeholder = "输入框"
            textF.frame = CGRect(x: 10, y: 10, width: 100, height: 30)
            currentWindow.addSubview(textF)
            
        }
        self.prevWindow = UIApplication.shared.keyWindow
        
        currentWindow.isHidden = false
                
//        currentWindow.makeKeyAndVisible()
        
        print(UIApplication.shared.windows, currentWindow)
    }
    
    @objc func subShowBtnClick() {
        if popContainer.isShowing() {
            popContainer.hideWith(animated: true)
        }else {
            popContainer.showWith(animated: true)
        }
       
    }
    
    @objc func modalShowBtnClick() {
       
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(prevWindow, currentWindow, UIApplication.shared.keyWindow)
    }
}

extension SSViewShowWayController {
    @objc func tapWindow() {
//        prevWindow.makeKey()
//
//        prevWindow.windowLevel = UIWindow.Level.statusBar
//        currentWindow.isHidden = true
//        currentWindow = nil
    }
    
    
}


class SSWindow: UIWindow {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
}
