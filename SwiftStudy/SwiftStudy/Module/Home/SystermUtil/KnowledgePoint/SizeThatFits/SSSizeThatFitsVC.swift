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
//        v.text = "hello,world"
//        v.textAlignment = .center
        view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
//            make.width.equalTo(200)
//            make.height.equalTo(200)
        }
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        v.sizeToFit()
    }
    
}

class SSSizeThatFitView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        print("size that fits")
        return CGSize(width: 100, height: 100)
    }
    
    override var intrinsicContentSize: CGSize {
        print("intrinsicContentSize")

        return CGSize(width: 180, height: 40)
    }
}
