//
//  SSUIKeyInputViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/12/31.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSUIKeyInputViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        let codeV = CodeView()
        codeV.backgroundColor = UIColor.qmui_random()
        view.addSubview(codeV)
        codeV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
        
    }

}


class PwdView: UIView, UIKeyInput {
    
    var text: String?
    var maxLength = 6
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    var hasText: Bool {
        guard let text = text else {
            return false
        }
        return text.count > 0
    }
    
    func insertText(_ text: String) {
        
    }
    
    func deleteBackward() {
        
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return
        }
        
    }
    
}

