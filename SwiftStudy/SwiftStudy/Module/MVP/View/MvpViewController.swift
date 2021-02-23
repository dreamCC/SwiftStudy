//
//  MvpViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/12/31.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit

class MvpViewController: SSBaseViewController {

    
    lazy var mvpPresenter = MvpPresenter()
    weak var bodyV: MvpBodyView!
    weak var inputV: MvpInputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func initSubviews() {
        super.initSubviews()
        
        view.backgroundColor = UIColor.white
        
        self.mvpPresenter.delegate = self
        
        let body = MvpBodyView()
        body.delegate = self
        view.addSubview(body)
        body.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(300)
            make.top.equalToSuperview().offset(20)
        }
        
        let input = MvpInputView()
        input.delegate = self
        view.addSubview(input)
        input.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(80)
            make.top.equalTo(body.snp.bottom).offset(20)
        }
        
        self.inputV = input
        self.bodyV  = body
    }
    
    
    deinit {
        print("MvpViewController=:释放-")
    }
    
    
}

extension MvpViewController: MvpPresenterDelegate {
    
    func startLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func stopLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func getValueComplement(model: MvpModel) {
        bodyV.updateUI(name: model.name, age: model.age, input: model.inputValue ?? "--")
    }
}

extension MvpViewController: MvpBodyViewDelegate, MvpInputViewDelegate {
    
    func fetchValueBtnClick() {
        mvpPresenter.getValue()
    }
    
    // 输入框内容变化
    func inputValueChange(value: String) {
        mvpPresenter.updateInputValue(value: value)
    }
}
