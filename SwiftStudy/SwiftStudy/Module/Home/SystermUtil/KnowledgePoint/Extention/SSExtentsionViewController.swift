//
//  SSExtentsionViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/11/19.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSExtentsionViewController: SSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

}


class ExtensionView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("ExtensionView-layoutSubviews")
    }
}

extension ExtensionView {
    
    
}


