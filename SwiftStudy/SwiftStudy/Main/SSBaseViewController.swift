//
//  SSBaseViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2019/12/26.
//  Copyright © 2019 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit

class SSBaseViewController: QMUICommonViewController {

    
    var titleName: String? {
        willSet {
            navigationItem.title = newValue
        }
    }
    
    weak var desLab: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    override func initSubviews() {
        super.initSubviews()
        UITabBar.appearance().barStyle = .black
        
        view.backgroundColor = UIColor.white
        
        let desLab = UILabel()
        desLab.numberOfLines = Int.max
        view.addSubview(desLab)
        self.desLab = desLab
        desLab.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
   

}
