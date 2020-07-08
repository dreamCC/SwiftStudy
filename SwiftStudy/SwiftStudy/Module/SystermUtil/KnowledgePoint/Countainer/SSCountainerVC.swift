//
//  SSCountainerVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/2.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import SnapKit

class SSCountainerVC: QMUICommonViewController {

    weak var demoV: UIView!
    override func initSubviews() {
        
        let demoV = UIView()
        demoV.backgroundColor = UIColor.qmui_random()
        view.addSubview(demoV)
        self.demoV = demoV
        
        let setBtn = QMUIButton()
        setBtn.setTitle("NSSet", for: .normal)
        setBtn.addTarget(self, action: #selector(setBtnClick), for: .touchUpInside)
        view.addSubview(setBtn)
        
        let hashBtn = QMUIButton()
        hashBtn.setTitle("hashBtn", for: .normal)
        hashBtn.addTarget(self, action: #selector(hasBtnClick), for: .touchUpInside)
        view.addSubview(hashBtn)
        
        let mapBtn = QMUIButton()
        mapBtn.setTitle("mapBtn", for: .normal)
        mapBtn.addTarget(self, action: #selector(mapBtnClick), for: .touchUpInside)
        view.addSubview(mapBtn)
        
        let pointBtn = QMUIButton()
        pointBtn.setTitle("pointBtn", for: .normal)
        pointBtn.addTarget(self, action: #selector(pointBtnClick), for: .touchUpInside)
        view.addSubview(pointBtn)
        
        demoV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
        
        setBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(hashBtn.snp.top).offset(-20)
        }
        
        hashBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.snp.centerY).offset(-10)
            
        }
        
        mapBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(pointBtn.snp.top).offset(-20)
            make.top.equalTo(self.view.snp.centerY).offset(10)
        }
        
        pointBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            
        }
     
        
        
        
        
    }

    @objc func setBtnClick() {
        let set = NSSet(array: [1,2,3,4,5,3,2,1])
        print(set)
    }
    
    @objc func hasBtnClick() {
        let hashTable = NSHashTable<AnyObject>(options: .weakMemory)
        hashTable.add(demoV)
        
        
    }
    
    @objc func mapBtnClick() {
        
        
    }
    
    @objc func pointBtnClick() {
        let selector = Selector("doSomeThing")
        self.perform(selector)
        
    }
    
    
    override class func resolveInstanceMethod(_ sel: Selector!) -> Bool {
        
        let superRes = super.resolveInstanceMethod(sel)
        print("\(sel)", superRes)
        return superRes
        
    }
    
    
    
  
}

