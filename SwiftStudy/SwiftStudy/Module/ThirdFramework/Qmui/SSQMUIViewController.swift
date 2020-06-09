//
//  SSQMUIViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 类的继承关系。
 NSObject基类->UIResponder(接受事件，内部有touchxxx点击事件、motionxxx加速计、remoteControlReceivedWithEvent远程控制)->UIView(显示)->UIControl（addTarge等方法）->UIButton。
 继承自UIResponse的有UIIVew、UIVIewController、UIApplication、AppDelegate。
 
 CALayer直接继承NSObject所以不能接受事件。
 
 
 QMUI是实现的逻辑，1、当QMUITheme.shareInstance.setThemeIdentify的时候，会调用notificyName方法，然后会调用UIview层的quuiThemeDidChangexxxx方法。
 然后在UIView的分类中，会重写获取view的一些属性进行赋值。
 
 
 
 */
class SSQMUIViewController: QMUICommonViewController {

   
    
    var btn: SSButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
      
        
    }
    

    override func initSubviews() {
        view.backgroundColor = UIColor.white
        
        btn = SSButton(type: .custom)
        btn.frame = CGRect(x: 10, y: 100, width: 0, height: 0)
        btn.backgroundColor = UIColor.qmui_random()
        btn.setTitle("button", for: .normal)
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        let toolBar = UIToolbar()
        
        view.addSubview(toolBar)
        toolBar.snp.makeConstraints { (make) in
            make.centerX.equalTo(btn)
            make.top.equalTo(btn.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        btn.sizeToFit()
    }
    

    
}

