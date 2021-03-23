//
//  SSDisplayLinkAnimationVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/18.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSDisplayLinkAnimationVC: QMUICommonViewController {

    let animationV: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.qmui_random()
        return v
    }()
    override func initSubviews() {
        title = "DisPlayLinkAnimtion"
        
        view.addSubview(animationV)
        animationV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
            make.top.equalToSuperview().offset(100)
        }
        let startAnimtion = QMUIButton()
        startAnimtion.setTitle("开始动画", for: .normal)
        startAnimtion.addTarget(self, action: #selector(displayLinkAnimationStart), for: .touchUpInside)
        view.addSubview(startAnimtion)
        startAnimtion.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

}

extension SSDisplayLinkAnimationVC {
    
    @objc func displayLinkAnimationStart() {
        
       
        
        /*
         QMUIDisplayLinkAnimation，其核心思想就是，通过CADispalyerLink来实现帧刷新。
         每次刷新，会通过fromValue和toValue来计算动画插值。
         我们拿到插值，进行复制。相比CAAnimation有一定的优势，病不会随着app切换页面或者从后台切换到前台出现动画
         动画停止的现象。
         
         */
        QMUIDisplayLinkAnimation.animate(withDuration: 5.0,
                                         easing: .easeInBounce,
                                         fromValue: UIColor.purple,
                                         toValue: UIColor.red) { (value) in
                                            self.animationV.backgroundColor = value as! UIColor
                                            
        }
        
    }
}
