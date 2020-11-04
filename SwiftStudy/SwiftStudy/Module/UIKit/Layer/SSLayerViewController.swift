//
//  SSLayerViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/1.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class SSLayerViewController: QMUICommonViewController {

    override func initSubviews() {
    
        let v = UIView()
        v.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        v.backgroundColor = UIColor.black
        view.addSubview(v)
        
        
        let layer1 = CALayer()
    
        layer1.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        //layer1.frame.origin = CGPoint(x: 10, y: 100)
        layer1.backgroundColor = UIColor.qmui_random().cgColor
        layer1.contents = UIImage(named: "icon_moreOperation_shareFriend")?.cgImage
        layer1.contentsScale = UIScreen.main.scale
        layer1.contentsGravity = .center
        //layer1.contentsRect  = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
        //layer1.contentsCenter = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
        //layer1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //layer1.position    = CGPoint(x: 10, y: 400)
        layer1.anchorPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(layer1)
        
        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索"
        searchBar.searchBarStyle = .prominent
        searchBar.showsScopeBar = true
        searchBar.prompt = "Prompt"
        searchBar.barStyle = .default
        searchBar.showsCancelButton = true
                view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(100)
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


class SV: UIView {
    
}
