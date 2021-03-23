//
//  SSLayerViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/1.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSLayerViewController: QMUICommonViewController {

    
    var v: SV!
    var v1: SV!
    var layer1: SVlayer!
    override func initSubviews() {
    
        v = SV()
        v.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        v.backgroundColor = UIColor.black
        view.addSubview(v)
        
     
        
        layer1 = SVlayer()
        layer1.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        //layer1.frame.origin = CGPoint(x: 10, y: 100)
        layer1.backgroundColor = UIColor.qmui_random().cgColor
        layer1.contents = UIImage(named: "icon_moreOperation_shareFriend")?.cgImage
        layer1.contentsScale = UIScreen.main.scale
        layer1.contentsGravity = .center
        //layer1.contentsRect  = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
        //layer1.contentsCenter = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
        //layer1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //layer1.position    = CGPoint(x: 10, y: 400)
        layer1.anchorPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(layer1)
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索"
        searchBar.searchBarStyle = .prominent
        searchBar.showsScopeBar = true
        searchBar.prompt = "Prompt"
        searchBar.barStyle = .default
        searchBar.showsCancelButton = true
                view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(100)
        }
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.v.layer.delegate = nil

        CATransaction.begin()
        CATransaction.setAnimationDuration(3)
       // self.layer1.backgroundColor = UIColor.qmui_random().cgColor
        self.v.frame = CGRect(x: 200, y: 200, width: 200, height: 50)
        CATransaction.commit()

//        UIView.animate(withDuration: 5) {
//
//            self.v.layer.frame = CGRect(x: 200, y: 200, width: 200, height: 50)
//        }
    }
}


class SVlayer: CALayer {
    
    override func action(forKey event: String) -> CAAction? {
        
        let action = super.action(forKey: event)
        print("layer action for key", action )
//        if event == "backgroundColor" {
//            let newA = CABasicAnimation(keyPath: event)
//            newA.duration = 5
//            return newA
//        }
        return action
//        return NSNull()
//        return nil
    }
}


class SV: UIView {
    
    
    override class var layerClass: AnyClass {
        return  SVlayer.self
    }
    
    
    override func action(for layer: CALayer, forKey event: String) -> CAAction? {
       let action = super.action(for: layer, forKey: event)
        print("UIView action for key", action )
        return action
        //return NSNull()
        //return nil
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        print("willMove to Window")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        print("willMove to superView")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews")

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print("draw rect")

    }
}
