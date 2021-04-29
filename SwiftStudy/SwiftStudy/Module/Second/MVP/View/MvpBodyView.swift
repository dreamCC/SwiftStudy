//
//  MvpBodyView.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/12/31.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

protocol MvpBodyViewDelegate: class {
    
    func fetchValueBtnClick()
}

class MvpBodyView: UIView, QMUITextFieldDelegate {
    
    weak var delegate: MvpBodyViewDelegate?

   lazy var fetchBtn: UIButton = {
    
        let btn = UIButton()
        btn.backgroundColor = UIColor.qmui_random()
        btn.setTitle("获取Value值", for: .normal)
        btn.addTarget(self, action: #selector(nameBtnClick), for: .touchUpInside)
        return btn
    }()
    
    
    lazy var nameLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.qmui_random()
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    lazy var ageLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.qmui_random()
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    lazy var inputLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.qmui_random()
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray

        addSubview(fetchBtn)
        fetchBtn.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        addSubview(nameLab)
        nameLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(fetchBtn.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        addSubview(ageLab)
        ageLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(nameLab.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        addSubview(inputLab)
        inputLab.snp.makeConstraints { (make) in
            make.bottom.equalTo(ageLab.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc func nameBtnClick() {
        delegate?.fetchValueBtnClick()
    }
   
    
}

extension MvpBodyView {
    
    func updateUI(name: String, age: String, input: String) {
        self.nameLab.text = name
        self.ageLab.text   = age
        self.inputLab.text = input
    }
    
}
