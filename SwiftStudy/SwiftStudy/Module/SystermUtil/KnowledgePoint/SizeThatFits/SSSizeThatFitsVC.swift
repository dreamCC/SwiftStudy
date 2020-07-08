//
//  SSSizeThatFitsVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/6/28.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSSizeThatFitsVC: QMUICommonViewController {

    var v: SSSizeThatFitView!
    override func initSubviews() {
        
        v = SSSizeThatFitView()
        v.backgroundColor = UIColor.qmui_random()
        v.frame = CGRect(x: 10, y: 100, width: 200, height: 50)
        v.text = "hello,world"
        v.textAlignment = .center
        view.addSubview(v)
//        v.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.width.equalTo(200)
//            make.height.equalTo(50)
//        }
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        v.sizeToFit()
    }
    
}

class SSSizeThatFitView: UILabel {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let returnSize = super.sizeThatFits(size)
        print(returnSize, size)
        return returnSize
    }
    
    
}
