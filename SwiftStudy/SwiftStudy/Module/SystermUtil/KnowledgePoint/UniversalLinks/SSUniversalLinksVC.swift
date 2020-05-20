//
//  SSUniversalLinksVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/9.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSUniversalLinksVC: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        titleName = "UniversalLink"
        
        
    }
    
    @IBAction func openUrl(_ sender: UIButton) {
        
        let url = URL(string: "https://www.baidu.com")!
        UIApplication.shared.open(url, options: [:]) { (isSuccess) in
            print(isSuccess)
        }
     
    }
    
    /*
     关于openUrl。UIApplication.OpenExternalURLOptionsKey.universalLinksOnly， 对应的value有两个值
     true和false。 如果UIApplication.OpenExternalURLOptionsKey.universalLinksOnly:true。 那么表示，
     如果没有安装相应的app， 并不会使用safari来打开。
     */
    @IBAction func openUrlUniversalLinks(_ sender: UIButton) {
        let url = URL(string: "https://www.baidu.com")!
        UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly:true]) { (isSuccess) in
            print(isSuccess)
        }
    }
}
