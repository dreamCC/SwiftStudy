
//
//  SSAnimationVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/9.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import pop

class SSAnimationVC: QMUICommonViewController {

    
  
    private var animationView: SSView = {
        let v = SSView()
        v.backgroundColor = UIColor.qmui_random()
        return v
    }()
    
    private var animationLayer: SSLayer = {
        let v = SSLayer()
        v.frame = CGRect(x: 100, y: 300, width: 50, height: 50)
        v.backgroundColor = UIColor.qmui_random().cgColor
        return v
    }()
    override func initSubviews() {

        
        view.addSubview(animationView)
        animationView.snp.makeConstraints { (make) in
            make.left.equalTo(100)
            make.top.equalTo(100)
            make.width.height.equalTo(50)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureStart))
        view.addGestureRecognizer(tapGesture)
        
        view.layer.addSublayer(animationLayer)
    
        let functionBtn = QMUIButton(type: .custom)
        functionBtn.setTitle("函数动画", for: .normal)
        functionBtn.addTarget(self, action: #selector(functionAnimationClick), for: .touchUpInside)
        view.addSubview(functionBtn)
        functionBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(150)
        }
        
        let blockAnimation = QMUIButton(type: .custom)
        blockAnimation.setTitle("block动画", for: .normal)
        blockAnimation.addTarget(self, action: #selector(blockAniamtionClick), for: .touchUpInside)
        view.addSubview(blockAnimation)
        blockAnimation.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(functionBtn.snp.bottom).offset(10)
        }
        
        let coreAnimation = QMUIButton(type: .custom)
        coreAnimation.setTitle("coreAniamtion动画", for: .normal)
        coreAnimation.addTarget(self, action: #selector(coreAnimationClick), for: .touchUpInside)
        view.addSubview(coreAnimation)
        coreAnimation.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(blockAnimation.snp.bottom).offset(10)
        }
        
        let dynamicAnimation = QMUIButton(type: .custom)
        dynamicAnimation.setTitle("dynamicAnimation动画", for: .normal)
        dynamicAnimation.addTarget(self, action: #selector(dynamicAnimationClick), for: .touchUpInside)
        view.addSubview(dynamicAnimation)
        dynamicAnimation.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(coreAnimation.snp.bottom).offset(10)
        }
        
        let layerFunc = QMUIButton(type: .custom)
        layerFunc.setTitle("layer", for: .normal)
        layerFunc.addTarget(self, action: #selector(layerClick), for: .touchUpInside)
        view.addSubview(layerFunc)
        layerFunc.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dynamicAnimation.snp.bottom).offset(10)
        }
        
       
     
        
        
    }

}

extension SSAnimationVC {
    
    @objc func tapGestureStart() {
        
        let basicAnimation = CABasicAnimation(keyPath: "transform")
        // CAAnimation的属性
        //basicAnimation.beginTime = CACurrentMediaTime()
        //basicAnimation.timeOffset = 1.0
        basicAnimation.duration = 2.0
        basicAnimation.repeatCount  = 1
        basicAnimation.speed = 1.0
        basicAnimation.fillMode = .forwards
        // basicAnimation.repeatDuration = 1.0
        
        // CABasicAnimation的属性
        // 起始值不设置，默认是初始值。CATransform3DIdentity
        // basicAnimation.fromValue = CATransform3DIdentity
        // basicAnimation.fromValue = CATransform3DMakeTranslation(100, 100, 0)
        basicAnimation.fromValue = CATransform3DMakeTranslation(200, 50, 0)
        animationView.layer.add(basicAnimation, forKey: nil)
        
    }
    
    @objc func functionAnimationClick()  {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.0)
        UIView.setAnimationCurve(.linear)
        UIView.setAnimationRepeatCount(2)
        
        // 进行的dong动画
        animationView.qmui_left = 200
        
        UIView.commitAnimations()
        
    }
    
    @objc func blockAniamtionClick() {
        
        /*
         frame //大小变化：改变视图框架（frame）和边界。
         bounds //拉伸变化：改变视图内容的延展区域。
         center //居中显示
         transform //仿射变换（transform）
         alpha //改变透明度：改变视图的alpha值。
         backgroundColor //改变背景颜色
         contentStretch //拉伸内容
        
         */
   
        
        UIView.animate(withDuration: 1.0) {
            self.animationView.qmui_left = 200
        }
        
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
//        UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: .calculationModeLinear, animations: {
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

        }, completion: nil)
        
       
    }
    
    /*
     CoreAnimation类关系。
     CAAniamtion遵循CAMediaTiming协议。
        该协议有几个重要属性主要是：
     
     CAAnimation基类。
        CAPropertyAnimation
            CABasicAnimation
                CASpringAnimation
            CAKeyFrameAnimation
        CATransition
        CAAnimationGroup
     
     */
    @objc func coreAnimationClick() {
     
            
          /* - `fromValue' non-nil. Interpolates between `fromValue' and the
          * current presentation value of the property.
          *
          * - `toValue' non-nil. Interpolates between the layer's current value
          * of the property in the render tree and `toValue'.
            如果不设置fromValue那么fromValue就是起始位置。
            如果不设置toValue，那么起始位置就是toValue。
         */
        
        // keyPath是CAProperty的属性。
        let basicAnimation = CABasicAnimation(keyPath: "transform")
        // CAAnimation的属性
        //basicAnimation.beginTime = CACurrentMediaTime()
        //basicAnimation.timeOffset = 1.0
        basicAnimation.duration = 2.0
        basicAnimation.repeatCount  = 1
        basicAnimation.speed = 1.0
        // basicAnimation.repeatDuration = 1.0
        
        // CABasicAnimation的属性
        // 起始值不设置，默认是初始值。CATransform3DIdentity
        // basicAnimation.fromValue = CATransform3DIdentity
        // basicAnimation.fromValue = CATransform3DMakeTranslation(100, 100, 0)
        basicAnimation.fromValue = CATransform3DMakeTranslation(200, 50, 0)
        //animationView.layer.add(basicAnimation, forKey: nil)
        
        
        // CASpringAnimation 弹性动画。
        // 心跳动画
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        keyFrameAnimation.values = [1, 0.5, 1, 1.5, 1]
        keyFrameAnimation.keyTimes = [NSNumber(value: 0),NSNumber(value: 0.5) ,NSNumber(value: 1)]
        keyFrameAnimation.repeatCount = MAXFLOAT
        keyFrameAnimation.duration = 2.0
        keyFrameAnimation.autoreverses = true
        keyFrameAnimation.isRemovedOnCompletion = false // 是否移动对layer的控制
        
        animationView.layer.add(basicAnimation, forKey: nil)
        
        
    }
    
    
    // 只有遵循了UIDynamicItem协议的才能进行仿真力学动画，UIView已遵循
    // CAEmitterLayer粒子动画
    @objc func dynamicAnimationClick() {
        let dynamicAnimatior = UIDynamicAnimator(referenceView: animationView)
    
        let grative = UIGravityBehavior(items: [view])
        dynamicAnimatior.addBehavior(grative)
        
        let collision = UICollisionBehavior(items: [view])
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimatior.addBehavior(collision)
        
        
    }
    
    @objc func layerClick() {
        

        // 默认layer的改变会进行隐士动画
        // 来显示管理动画
        CATransaction.begin()
        // 关闭动画
        //CATransaction.setDisableActions(true)
        CATransaction.setAnimationDuration(3)
        
        //animationLayer.bounds = CGRectMakeWithSize(CGSize(width: 200, height: 200))
        self.animationView.layer.bounds = CGRectMakeWithSize(CGSize(width: 200, height: 200))
        
        CATransaction.commit()
        
        //self.animationView.bounds = CGRectMakeWithSize(CGSize(width: 200, height: 200))
        
    }
}
