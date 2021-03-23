//
//  SSProgressViewVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/29.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSProgressViewVC: QMUICommonViewController {

   
    private var pieProgressV: QMUIPieProgressView!
    override func initSubviews() {
    
        pieProgressV = QMUIPieProgressView()
        view.addSubview(pieProgressV)
        pieProgressV.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //pieProgressV.progress = pieProgressV.progress + 0.1
        pieProgressV.setProgress(pieProgressV.progress + 0.1, animated: true)
    }

}
