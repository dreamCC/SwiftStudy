//
//  AirDropViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/3/30.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

/*
 AirDrop其实很简单，如果我们想通过AirDrop、分享，可以直接使用UIActivityViewController。
 
 如果想让我们app有接受AirDrop功能。那么就需要在info.plist中进行配置。 增加DocumentType。
 
 其实就是配置UTI。
 https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/UTIRef/Articles/System-DeclaredUniformTypeIdentifiers.html
 
 可在此网站上参考相应的uti集合，根据需要进行配置。
 */
class AirDropViewController: SSBaseViewController {

    override func initSubviews() {
        super.initSubviews()
        
        let btn = UIButton(type: .system)
        btn.setTitle("ActionController", for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    @objc func btnClick() {
        

        let str = "hello, activity"
        let image = UIImage(named: "loading")!
        let url = NSURL(string: "www.baidu.com")!
        let actionVc = UIActivityViewController(
            activityItems: [str, image, url],
            applicationActivities: nil)
        
        self.present(actionVc, animated: true, completion: nil)
        
    }

}
