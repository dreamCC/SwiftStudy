//
//  SSFloatLayoutViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/28.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSFloatLayoutViewController: QMUICommonViewController {

    private var dev: SDView!
    private var devLayer: SDLayer!
    override func initSubviews() {
        
        /*
         有个特点就是，子类控件高度是通过 sizeThatFit来获取的。
         */
        let floatLayoutV = QMUIFloatLayoutView()
        floatLayoutV.backgroundColor = UIColor.qmui_random()
        floatLayoutV.layer.borderWidth = 1
        floatLayoutV.layer.borderColor = UIColor.red.cgColor
        floatLayoutV.itemMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.addSubview(floatLayoutV)
        floatLayoutV.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(200)
            make.top.equalTo(100)
        }
        
        let strAry = ["hello","中国","琴图无线","女气爆发","hello","中国","琴图无线","女气爆发","hello",
                      "中国","琴图无线","女气爆发","hello","中国","琴图无线","女气爆发"]
        strAry.forEach { (value) in
            let lab = QMUILabel()
            lab.text = value
            lab.backgroundColor = UIColor.qmui_random()
            lab.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            lab.layer.cornerRadius = 5
            lab.clipsToBounds = true
            floatLayoutV.addSubview(lab)
            
        }
        
        let gridV = QMUIGridView()
        gridV.columnCount = 3
        gridV.rowHeight = 40
        view.addSubview(gridV)
        gridV.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(200)
            make.top.equalTo(floatLayoutV.snp.bottom).offset(20)
        }
        
        let gridAry = ["hello","中国","琴图无线","女气爆发","hello","中国","琴图无线","女气爆发","hello",
                       "中国","琴图无线","女气爆发","hello","中国","琴图无线","女气爆发"]
        gridAry.forEach { (value) in
            let lab = QMUILabel()
            lab.text = value
            lab.canPerformCopyAction = true
            lab.backgroundColor = UIColor.qmui_random()
            lab.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            lab.layer.cornerRadius = 5
            lab.clipsToBounds = true
            gridV.addSubview(lab)
            
        }
        
        let marqueelLab = QMUIMarqueeLabel()
        marqueelLab.text = "SwiftStudy[1333:43493] iVersion update check failed because: The application could not be found"
        marqueelLab.textColor = UIColor.qmui_random()
        marqueelLab.backgroundColor = UIColor.gray
        view.addSubview(marqueelLab)
        marqueelLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(gridV.snp.bottom).offset(20)
            make.size.equalTo(CGSize.init(width: 300, height: 40))
        }
        
        
        dev = SDView()
        dev.backgroundColor = UIColor.qmui_random()
        // 该属性能标记当dev的尺寸改变会调用drawRect方法。
        // dev.contentMode = UIView.ContentMode.redraw
        dev.frame = CGRect(x: 10, y: UIScreen.main.bounds.size.height - 100, width: 200, height: 40)
        view.addSubview(dev)
//        dev.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.size.equalTo(CGSize(width: 200, height: 40))
//            make.bottom.equalTo(-200)
//        }
        
        
//        devLayer = SDLayer()
//        devLayer.frame = CGRect(x: 10, y: UIScreen.main.bounds.size.height - 100, width: 200, height: 40)
//        devLayer.backgroundColor = UIColor.qmui_random().cgColor
//        view.layer.addSublayer(devLayer)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        dev.backgroundColor = UIColor.qmui_random()
        dev.frame = CGRect(x: 10, y: UIScreen.main.bounds.size.height - 100, width: 300, height: 40)
//        devLayer.backgroundColor = UIColor.qmui_random() as! CGColor
    }

}


class SDView: UIView {
    
    
    override class var layerClass: AnyClass {
        get {
            return SDLayer.self
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        print("SDView","draw rect")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("SDView","layout sub views")
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        print("SDView","willMoveToWindow", newWindow)
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        print("SDView","didMoveToWindow", self.window)
    }
    
    
    
    override func action(for layer: CALayer, forKey event: String) -> CAAction? {
        print("SDView","action: forLayay:\(layer) forKey: \(event)", super.action(for: layer, forKey: event))
       
        return super.action(for: layer, forKey: event)
    }
}

class SDLayer: CALayer {
    
    
    // 布局子layer
    override func layoutSublayers() {
        super.layoutSublayers()
        print("SDLayer", "layoutSublayers")
    }
    
    // 绘图
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        print("SDLayer", "draw in ctx")

    }
    
    override func action(forKey event: String) -> CAAction? {
        print("SDLayer", "action: forKey:\(event)", super.action(forKey: event))
        if event == "bounds" {
            let action = CABasicAnimation(keyPath: event)
            action.fromValue = self.value(forKey: event)
            action.duration = 2.0
            return action
        }
        return super.action(forKey: event)
    }
    
    
    
    
}
