//
//  MvvmViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/14.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

class MvvmViewController: SSBaseViewController {

    lazy var observableBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Observable", for: .normal)
        btn.addTarget(self, action: #selector(observableBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var driverBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Driver", for: .normal)
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        view.backgroundColor = UIColor.white
        view.addSubview(observableBtn)
        observableBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
     
        view.addSubview(driverBtn)
        driverBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(observableBtn.snp.bottom).offset(20)
        }
        
        driverBtn.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe {[unowned self]  (Void) in
                self.navigationController?.pushViewController(GithubDriverViewController(), animated: true)
            }.disposed(by: disposeBag)

    }

    deinit {
        print("MvvmViewController  释放")
    }
    
    @objc func observableBtnClick() {
        navigationController?.pushViewController(GithubDriverViewController(), animated: true)
    }
}
