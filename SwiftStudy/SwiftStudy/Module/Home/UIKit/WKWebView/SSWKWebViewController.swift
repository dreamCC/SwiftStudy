//
//  SSWKWebViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/12/21.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import WebKit

class SSWKWebViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let webConfig = WKWebViewConfiguration()
        let webV = WKWebView(frame: CGRect.zero, configuration: webConfig)
        webV.uiDelegate = self
        webV.navigationDelegate = self
    
        view.addSubview(webV)
        webV.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    

    

}

extension SSWKWebViewController: WKUIDelegate {
    
    
}

extension SSWKWebViewController: WKNavigationDelegate {
    
}

