//
//  SSCoreFoundationVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/4/22.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 Quartz core和CoreGraphics的区别。
 Quartz core是以CA开头的核心绘图层，主要是CoreAnimtion.h, 我们常用的CAAnimtion、CADisplayLink、CALayer、CAShapelayer等。
 #include <QuartzCore/CATransform3D.h>

 #import <Foundation/Foundation.h>
 #import <QuartzCore/CAAnimation.h>
 #import <QuartzCore/CADisplayLink.h>
 #import <QuartzCore/CAEAGLLayer.h>
 #import <QuartzCore/CAMetalLayer.h>
 #import <QuartzCore/CAEmitterCell.h>
 #import <QuartzCore/CAEmitterLayer.h>
 #import <QuartzCore/CAGradientLayer.h>
 #import <QuartzCore/CALayer.h>
 #import <QuartzCore/CAMediaTiming.h>
 #import <QuartzCore/CAMediaTimingFunction.h>
 #import <QuartzCore/CAReplicatorLayer.h>
 #import <QuartzCore/CAScrollLayer.h>
 #import <QuartzCore/CAShapeLayer.h>
 #import <QuartzCore/CATextLayer.h>
 #import <QuartzCore/CATiledLayer.h>
 #import <QuartzCore/CATransaction.h>
 #import <QuartzCore/CATransform3D.h>
 #import <QuartzCore/CATransformLayer.h>
 #import <QuartzCore/CAValueFunction.h>
 
 而CoreGraphic是图形层框架。主要是CG开头的类。
 #include <CoreGraphics/CGBase.h>

 #include <CoreGraphics/CGAffineTransform.h>
 #include <CoreGraphics/CGBitmapContext.h>
 #include <CoreGraphics/CGColor.h>
 #include <CoreGraphics/CGColorConversionInfo.h>
 #include <CoreGraphics/CGColorSpace.h>
 #include <CoreGraphics/CGContext.h>
 #include <CoreGraphics/CGDataConsumer.h>
 #include <CoreGraphics/CGDataProvider.h>
 #include <CoreGraphics/CGError.h>
 #include <CoreGraphics/CGFont.h>
 #include <CoreGraphics/CGFunction.h>
 #include <CoreGraphics/CGGeometry.h>
 #include <CoreGraphics/CGGradient.h>
 #include <CoreGraphics/CGImage.h>
 #include <CoreGraphics/CGLayer.h>
 #include <CoreGraphics/CGPDFArray.h>
 #include <CoreGraphics/CGPDFContentStream.h>
 #include <CoreGraphics/CGPDFContext.h>
 #include <CoreGraphics/CGPDFDictionary.h>
 #include <CoreGraphics/CGPDFDocument.h>
 #include <CoreGraphics/CGPDFObject.h>
 #include <CoreGraphics/CGPDFOperatorTable.h>
 #include <CoreGraphics/CGPDFPage.h>
 #include <CoreGraphics/CGPDFScanner.h>
 #include <CoreGraphics/CGPDFStream.h>
 #include <CoreGraphics/CGPDFString.h>
 #include <CoreGraphics/CGPath.h>
 #include <CoreGraphics/CGPattern.h>
 #include <CoreGraphics/CGShading.h>
我们最常用的是CGColor、CGImage、CGPath。

 */
class SSQuartzAndCoreGraphicsVC: UIViewController {
    

    let datas = ["CGContext",""]
 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSHomeDirectory())
        
        navigationItem.title = "Quartz"
        
        let tabV = UITableView()
        tabV.dataSource = self
        tabV.delegate   = self
        tabV.tableFooterView = UIView()
        view.addSubview(tabV)
        tabV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
    }



}

extension SSQuartzAndCoreGraphicsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = datas[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(SSCGContextVC(), animated: true)
        }else {
            
            
        }
        
    }
    
    
   
}


