//
//  SSLayer.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/10.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 动画属性。对于一些属性Animatable的，有两个特点1、当设置属性时候时候，会有隐式动画。2、可以通过keypath进行动画。
 那么其内部是怎么实现的：
 1、通过 self.delegate?.action?(for: self, forKey: "position"), 获取CAAction协议对象。
 2、这个返回对象有三种情况：
    a、如果返回对象是nil的会进行默认的隐式动画。
    b、如果返回一个NUll对象，则不进行动画。
    c、如果是一个正确CAAction协议对象，则生成CAAnimtion动画，并执行动画。
 
所以对一个属性进行赋值是否有动画的核心原理是其layer.delegate.action（for: self， forKey：xx） 是否会返回CAAction对象。
    返回nil，隐式动画。
    返回NSNull，则不执行动画。
    返回CAAction，则执行动画。
 
 - (void)setPosition:(CGPoint)position
 {
 //    [super setPosition:position];
     if ([self.delegate respondsToSelector:@selector(actionForLayer:forKey:)]) {
         id obj = [self.delegate actionForLayer:self forKey:@"position"];
         if (!obj) {
             // 隐式动画
         } else if ([obj isKindOfClass:[NSNull class]]) {
             // 直接重绘（无动画）
         } else {
             // 使用obj生成CAAnimation
             CAAnimation * animation;
             [self addAnimation:animation forKey:nil];
         }
     }
     // 隐式动画
 }

如果这个layer被一个View持有，那么layer.delegate = view。 这也就是说UIView是默认遵循了CALayerDelegate协议的。当然事实的确如此。
 
 
动画的绘制原理。CALayer内部有两个layer，presentationLayer用于显示、modalLayer用于保存layer的各种属性。 每次属性信号来，也就是屏幕进行一次
刷新（一般会小于1/60 s），那么presentationLayer就会询问modalayer的属性，进行属性渲染（这也就说明，当我们多次对layer.backgroud赋值）。其实并不会多次刷新，只会在屏幕刷新的时候更新渲染。 我们一般设置属性，只是会修改modalLayer的属性，比如我们设置三次layer.frame.x ，那么实际上市modalLayer移动到最后一次的位置，下一次屏幕渲染的时候presentationLayre会询问modalLayer，问你在哪里？，
 

关于layer的mask属性。 注意对mask的理解。
 
 
 */
class SSLayer: CALayer {

    
    override func action(forKey event: String) -> CAAction? {
    
        let action = super.action(forKey: event)
        print("action forKey",event, action)
        //return nil
        return action
    }
    
    
    override class func defaultAction(forKey event: String) -> CAAction? {
    
        let action = super.defaultAction(forKey: event)
        print("defaultAction",event, action)

        return action
    }
    

    
//    override func display() {
//        super.display()
//        print("layer:display---")
//    }
//
//    override func draw(in ctx: CGContext) {
//        super.draw(in: ctx)
//        print("layer:draw in context---")
//
//
//    }
//
//
//    override func add(_ anim: CAAnimation, forKey key: String?) {
//        // print(anim)
//        super.add(anim, forKey: key)
//    }
    
    
    
    
    
}
