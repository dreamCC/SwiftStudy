//
//  SSUIPropertyAnimatorVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/24.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSUIViewPropertyAnimatorVC: QMUICommonViewController {

    let animationV: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.qmui_random()
        v.layer.cornerRadius = 4
        return v
    }()
    
    let startAnimBtn: UIButton = {
        let btn = QMUIButton(type: .custom)
        btn.setTitle("开始动画", for: .normal)
        return btn
    }()
    
    let pauseAnimBtn: UIButton = {
        let btn = QMUIButton()
        btn.setTitle("暂停动画", for: .normal)
        return btn
    }()
    
    let stopAnimBtn: UIButton = {
        let btn = QMUIButton()
        btn.setTitle("停止动画", for: .normal)
        return btn
    }()
    
    var viewPropertyAnim: UIViewPropertyAnimator!
    
    override func initSubviews() {
        
        
        view.addSubview(animationV)
        animationV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.height.equalTo(80)
        }
        
      
        startAnimBtn.addTarget(self, action: #selector(startAnimation), for: .touchUpInside)
        view.addSubview(startAnimBtn)
        startAnimBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        pauseAnimBtn.addTarget(self, action: #selector(pauseAnimation), for: .touchUpInside)
        view.addSubview(pauseAnimBtn)
        pauseAnimBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(startAnimBtn.snp.bottom).offset(20)
        }
        
        stopAnimBtn.addTarget(self, action: #selector(stopAnimation), for: .touchUpInside)
        view.addSubview(stopAnimBtn)
        stopAnimBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(pauseAnimBtn.snp.bottom).offset(20)
        }
        
       

        viewPropertyAnim = UIViewPropertyAnimator(duration: 5.0, curve: .linear) {
            self.animationV.center = CGPoint(x: 10, y: 300)
            self.animationV.alpha = 0.1
        }

    
    }

    
}


extension SSUIViewPropertyAnimatorVC {
    
    @objc func startAnimation() {
        
        viewPropertyAnim.startAnimation()
    }
    
    @objc func pauseAnimation() {
        viewPropertyAnim.pauseAnimation()
    }
    
    @objc func stopAnimation() {
        viewPropertyAnim.stopAnimation(true)
    }
    
}



