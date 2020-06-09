
//
//  SSAnimationVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/9.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSAnimationVC: QMUICommonViewController {

  
    private var animationView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.red
        return v
    }()
    private var animationView2: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.purple
        return v
    }()
    override func initSubviews() {

        
        view.addSubview(animationView)
        animationView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(100)
            make.width.height.equalTo(50)
        }
        
        view.addSubview(animationView2)
        animationView2.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(100)
            make.width.height.equalTo(50)
        }
        
        let functionBtn = QMUIButton(type: .custom)
        functionBtn.setTitle("函数动画", for: .normal)
        functionBtn.addTarget(self, action: #selector(functionAnimation), for: .touchUpInside)
        view.addSubview(functionBtn)
        functionBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(150)
        }
        
        let blockAnimation = QMUIButton(type: .custom)
        blockAnimation.setTitle("block动画", for: .normal)
        blockAnimation.addTarget(self, action: #selector(blockAniamtion), for: .touchUpInside)
        view.addSubview(blockAnimation)
        blockAnimation.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(functionBtn.snp.bottom).offset(10)
        }
        
        
    }

}

extension SSAnimationVC {
    
    @objc func functionAnimation()  {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.0)
        UIView.setAnimationCurve(.linear)
        UIView.setAnimationRepeatCount(2)
        
        // 进行的dong动画
        animationView.qmui_left = 200
        
        UIView.commitAnimations()
        
    }
    
    @objc func blockAniamtion() {
        
        /*
         frame //大小变化：改变视图框架（frame）和边界。
         bounds //拉伸变化：改变视图内容的延展区域。
         center //居中显示
         transform //仿射变换（transform）
         alpha //改变透明度：改变视图的alpha值。
         backgroundColor //改变背景颜色
         contentStretch //拉伸内容
        
         */
   
        
//        UIView.animate(withDuration: 1.0) {
//            self.animationView.qmui_left = 200
//        }
        
        /*
        UIView.animate(withDuration: TimeInterval,
                         animations: ()->Void)

        UIView.animate(withDuration: TimeInterval,
                         animations: ()->Void,
                         completion: ()->Void)

        // 带动画曲线动画
        UIView.animate(withDuration: TimeInterval,
                              delay: TimeInterval,
                            options: UIViewAnimationOptions,
                         animations: ()->Void,
                         completion: (()->Void)?)

        // 带弹性动画
        UIView.animate(withDuration: TimeInterval,
                              delay: TimeInterval,
             usingSpringWithDamping: 0,
              initialSpringVelocity: 0,
                            options: UIViewAnimationOptions,
                         animations: ()->Void,
                         completion: (()->Void)?)
 
        */
        
        // 帧动画。
//        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: .calculationModeLinear, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3) {
//                self.animationView.qmui_left = 200
//            }
//
//            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
//                self.animationView.qmui_top = 150
//            }
//
//            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
//                self.animationView.qmui_left = 50
//            }
//        }, completion: nil)
        
        // 过渡动画
        UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: {

            self.animationView2.isHidden = true
        }, completion: nil)
        
       
    }
    
    /*
     CoreAnimation类关系。
     CAAnimation基类。
        CAPropertyAnimation
            CABasicAnimation
                CASpringAnimation
            CAKeyFrameAnimation
        CATransition
        CAAnimationGroup
     
     */
    @objc func coreAnimation() {
     
        let basicAnimation = CABasicAnimation(keyPath: "")
        
        animationView.layer.add(basicAnimation, forKey: nil)
    }
}
