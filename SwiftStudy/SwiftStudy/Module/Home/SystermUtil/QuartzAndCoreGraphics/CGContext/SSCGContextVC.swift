//
//  SSCGContextVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/24.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit

class SSCGContextVC: QMUICommonViewController {

  
    var player: AVPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        let ctv = ContextView()
        ctv.backgroundColor = UIColor.lightGray
        view.addSubview(ctv)
        ctv.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
      
        
        let asset = AVAsset(url: URL(string: "http://v.jxvdy.com/sendfile/w5bgP3A8JgiQQo5l0hvoNGE2H16WbN09X-ONHPq3P3C1BISgf7C-qVs6_c8oaw3zKScO78I--b0BGFBRxlpw13sf2e54QA")!)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        

        player.play()
        
        
        let playerLayer = AVPlayerLayer(player: player)

        playerLayer.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
        playerLayer.backgroundColor = UIColor.purple.cgColor
        view.layer.addSublayer(playerLayer)
        
        print(type(of: asset))
        // audio Session几种常见类型 ambient（玩游戏时候听音乐）、soloAmbient（只能播放当前app）、record录制（微信语音）、playBack（背景播放比如qq音乐）
    
        
                    
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    @objc func timerStart() {
        print("timer start===")
    }
    
    deinit {
        print("SSCGContextVc 释放了")
    }
}

extension SSCGContextVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return TransiontToolUtil()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransiontToolUtil()
    }
}


class TransiontToolUtil:NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    
}

class ContextView: UIView {

    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext()
        
        
        print(String(format: "%p", ctx! as! CVarArg))
    }
}

class ContextLayer: CALayer {
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        print(String(format: "layer === %p", ctx as! CVarArg))
        
    
        ctx.addRect(CGRect(x: 10, y: 10, width: 100, height: 100))
        ctx.setLineWidth(5)
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.strokePath()
        
        
    }
    
    
}
