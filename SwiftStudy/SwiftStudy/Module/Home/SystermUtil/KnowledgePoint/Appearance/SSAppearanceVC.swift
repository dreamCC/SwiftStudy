//
//  SSAppearanceVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/8.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit

/*
 Appearance其实是一个单利。内部实现原理：
 1、创建一个单利对象。外部通过[XXX appearance] 获取。
 2、初始化的时候，init方法，会判断单利对象是否存在，如果存在，就获取单利对象的属性，同时赋值。
 3、当我们重写设置新值的时候，会将该值覆盖。如果不设置不会覆盖。
 
 
 所以说，Appearance一般需要提前设置。
 
 */
class SSAppearanceVC: QMUICommonViewController {

    
    lazy var appearanceBtn: QMUIButton = {
        let btn = QMUIButton(type: .custom)
        btn.setTitle("AppearanceStart", for: .normal)
        btn.backgroundColor = UIColor.qmui_random()
        return btn
    }()
    
    var constransW: Constraint!
    override func initSubviews() {
        
        view.backgroundColor = UIColor.white
        view.addSubview(appearanceBtn)
        appearanceBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            self.constransW =  make.width.equalTo(100).constraint
            make.height.equalTo(30)
        }
    }
  
    
    // 做一些更新
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 1.0) {
            self.constransW.update(offset: 150)
            self.view.layoutIfNeeded()
        }
        
    }
    
}


