//
//  SSTextFieldViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/6.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSTextFieldViewController: QMUICommonViewController {

    override func initSubviews() {
        
        let field = QMUITextField()
        field.borderStyle = .roundedRect
        field.maximumTextLength = 5
        field.placeholder = "手机号"
        view.addSubview(field)
        
        field.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        
        let textView = QMUITextView()
        textView.placeholder = "意见"
        textView.dataDetectorTypes = .link
        //textView.qmui_borderWidth = 1
        //textView.qmui_borderColor = UIColor.qmui_random()
        //textView.qmui_keyboardManager = QMUIKeyboardManager
        //textView.typingAttributes  = []
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(field.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
    }

}
