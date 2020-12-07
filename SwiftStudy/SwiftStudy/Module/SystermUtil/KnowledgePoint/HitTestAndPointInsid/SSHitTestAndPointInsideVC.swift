//
//  SSHitTestAndPointInsideVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/3.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import QMUIKit


/*
 ios事件的传递和事件的响应。
 事件传递。
 1、当点击屏幕会出现一个事件，这个时间会有UIApplication保存在事件队列（注意队列和栈的区别）中。
 2、UIApplication会启动runloop同时，将事件传递给keyWindow。
 3、keyWindow如果能响应事件（userInterfactationEnable = true、hidden = false、 alpha > 0.01）那么keyWindow会找到rootViewContorller以及相应的subViews依次类推直到找到合适view。
那么如何找到合适的view。会牵扯到两个重要方法。
 -hitTest 和 pointInside。 这两个方法为了寻找最佳的响应view，开发者可以重写。调用顺序父类、super.subviews.last、super.subviews.xx依次类推，如果找到合适响应的view，那么其他的就不会调用（比如我们重写父类的该方法，返回指定view那么子类就会不调用）。
 
 
 事件响应。
 事件响应，有first responser 想下传递。如果整个过程都没有响应这个事件，该事件就被丢弃。一般情况下，在响应者链中只要由对象处理事件，事件就停止传递。
 1、找到最合适的view，会响应响应的点击事件，比如touchBegan方法，如果最合适的view没有重写touchBegan方法，那么事件会向上传递。如果重写则不会传递
 （因为默认touchBegan方法内部会调用super.touchesBegan(touches,with:event)方法，当然也已可以通过nextResponder.touchBegans）。以此类推，如果都不处理，那么会传递到UIApplication如果不处理，那么就是丢弃。
 
在事件的响应中，如果某个控件实现了touches...方法，则这个事件将由该控件来接受，如果调用了[supertouches….];就会将事件顺着响应者链条往上传递，传递给上一个响应者；接着就会调用上一个响应者的touches….方法

 因为系统默认做法是把事件上抛给父控件，所以可以通过重写自己的touches方法和父控件的touches方法来达到一个事件多个对象处理的目的。

 
 */
class SSHitTestAndPointInsideVC: QMUICommonViewController {

    
   fileprivate weak var v3: SSQMUI3View!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        
    }
    
    override func initSubviews() {
        
        let v3 = SSQMUI3View()
        v3.backgroundColor = UIColor.blue
        v3.frame = CGRect(x: 20, y: 120, width: 100, height: 100)
        v3.isUserInteractionEnabled = true
        view.addSubview(v3)
        self.v3 = v3
        v3.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalToSuperview().offset(120)
            make.size.equalTo(CGSize(width: 150, height: 150))
        }
        let gestureV3 = UITapGestureRecognizer(target: self, action: #selector(tapV3))
        gestureV3.cancelsTouchesInView = false
        gestureV3.delegate = self
        v3.addGestureRecognizer(gestureV3)
        
        let v1 = SSQMUIView()
        v1.backgroundColor = UIColor.red
        v3.addSubview(v1)
        v1.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(20)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        let v2 = SSQMUI2View()
        v2.backgroundColor = UIColor.purple
        v3.addSubview(v2)
        v2.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(v1.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        let gestureV2 = UITapGestureRecognizer(target: self, action: #selector(tapV2))
//        gestureV2.cancelsTouchesInView = false
//        gestureV2.numberOfTapsRequired = 2
        gestureV2.delegate = self
        v2.addGestureRecognizer(gestureV2)
        
//        let doubleGestureV3 = UITapGestureRecognizer(target: self, action: #selector(doubleTapV3))
//        doubleGestureV3.numberOfTapsRequired = 1
//        v3.addGestureRecognizer(doubleGestureV3)
    }
    
    
    @objc func tapV3() {
        print("tapV3")
    }
    
    @objc func tapV2() {
        print("tapV2")
    }
    
    @objc func doubleTapV3() {
        print("doubleTapV3")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        print("vc-touchesBegan")
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("vc-touchesEnded")

    }

}



extension SSHitTestAndPointInsideVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
}

