//
//  RViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/4/16.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved./Users/zhuchaojun/Documents/宝藏/SwiftStudy/SwiftStudy/Podfile.lock
//

import UIKit


class RViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        view.backgroundColor = UIColor.white
        print(R.image.catGif.name, R.image.catGif.bundle.bundlePath, R.image.loading.name, R.image.loading.bundle)
        
            
        let v = UIView()
        v.backgroundColor = UIColor(named: "red")
        view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
      
    }

}
