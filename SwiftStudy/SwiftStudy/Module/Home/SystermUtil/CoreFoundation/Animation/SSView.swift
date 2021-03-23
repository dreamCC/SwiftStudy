//
//  SSView.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/10.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit


class SSView: UIView {
    
    override class var layerClass: AnyClass {
        get {
            return SSLayer.self
        }
    }

    // 用来控制layer的动画。属于CALayerDelegate
    // CAAnimtion遵循CAAction动画
    override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        let action = super.action(for: layer, forKey: event)
        print(event, action)
        if(event == "bounds"){
            let animation = CABasicAnimation()
            animation.duration = 2.0
            return animation
        }
        return action
    }

    override func layoutSublayers(of layer: CALayer) {
        print("layoutSublayers", layer)
        super.layoutSublayers(of: layer)
    }
    
    override func layerWillDraw(_ layer: CALayer) {
        print("layerWillDraw", layer)
        super.layerWillDraw(layer)
    }
    
    
    override func display(_ layer: CALayer) {
        print("display", layer)
        super.display(layer)
    }
    
    // 执行动画
    override class func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void) {
        
        //animations()
        super.animate(withDuration: duration, animations: animations)
    }

    
}
