//
//  IdfaViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/3/9.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit
import AppTrackingTransparency
import AdSupport

class IdfaViewController: SSBaseViewController {

    
    private lazy var btn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("idfa", for: .normal)
        btn.addTarget(self, action: #selector(idfaBtnClick), for: .touchUpInside)
        return btn
    }()
    
    override func initSubviews() {
        super.initSubviews()
        
    
        view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    @objc  func idfaBtnClick() {
        
        var idfa: String = "null"
        if #available(iOS 14, *) {
            // ios 14之后，idfa的获取采用弹窗形式，让用户更加直接的的使用idfa。
            ATTrackingManager.requestTrackingAuthorization { (status) in
                if status == .authorized {
                    idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                    print("idfa的值",idfa)

                }
            }
        } else {
            idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        }
        
        print("idfa的值",idfa)
        
    }

}
