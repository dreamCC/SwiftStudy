//
//  UIBezelPathViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/29.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

class UIBezelPathViewController: QMUICommonViewController {

    
    override func initSubviews() {
        
      
        let v = ChildView()
        v.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        
        UIGraphicsBeginImageContext(CGSize(width: 200, height: 200))

//        let bezelP = UIBezierPath(rect: CGRect(x: 10, y: 10, width: 100, height: 100))
//        UIColor.qmui_random().setStroke()
//        bezelP.stroke()
        
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.move(to: CGPoint(x: 20, y: 20))
        ctx?.addRect(CGRect(x: 50, y: 50, width: 100, height: 100))
        ctx?.setStrokeColor(UIColor.qmui_random().cgColor)
        ctx?.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let imageV = UIImageView(image: image)
        imageV.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        view.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.top.equalTo(v.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        
        
        //
        let bezelP = UIBezierPath(rect: CGRect(x: 10, y: 10, width: 100, height: 100))
        UIColor.red.setStroke()
        bezelP.stroke()
        
        let shapeL = CAShapeLayer()
        shapeL.frame = CGRect(x: 10, y: 130, width: 200, height: 200)
        shapeL.path = bezelP.cgPath
        shapeL.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        shapeL.strokeColor = UIColor.purple.cgColor
        shapeL.lineWidth = 4
        shapeL.fillColor = UIColor.white.withAlphaComponent(0).cgColor
        view.layer.addSublayer(shapeL)
        
        
        let s: String = ""
    }
    
   

}


class ChildView: UIView {
    
    override func draw(_ rect: CGRect) {
        let bezelP = UIBezierPath(rect: CGRect(x: 10, y: 10, width: 100, height: 100))
        
        UIColor.qmui_random().setStroke()
        bezelP.stroke()
        
    }
}
