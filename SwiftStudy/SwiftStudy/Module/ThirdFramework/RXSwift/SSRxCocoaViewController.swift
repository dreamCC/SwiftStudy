//
//  SSRxSwiftUIViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/9.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SSRxCocoaViewController: QMUICommonViewController {


    private let disposeBag = DisposeBag()
    override func initSubviews() {
     
        // 常用控件rx
        let rxBtn = QMUIButton()
        rxBtn.setTitle("rxButton", for: .normal)
        view.addSubview(rxBtn)
        rxBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(100)
        }
        // 基于UIButton的一些常用事件
        rxBtn.rx.controlEvent(.touchUpInside).subscribe { _ in
            print("touchUpInside")
        }.disposed(by: disposeBag)
        
        rxBtn.rx.tap.subscribe { _ in
            print("start Tap")
        }.disposed(by: disposeBag)
        
        
    }

}

extension SSRxCocoaViewController {
    
    func uilable() {
        
        let lab = UILabel()
        
       let interval =  Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        interval.map { "当前的事件：\($0)" }.bind(to: lab.rx.text).disposed(by: disposeBag)
        
    }
    
    func uitextFieldOrView() {
        
        let textField = UITextField()
        
        textField
            .rx.text
            .orEmpty
            .subscribe { (event: Event<String>) in
                print(event)
        }
        
        // 监听事件
        textField.rx.controlEvent([.editingDidBegin, .editingDidEnd])
            .subscribe { (event: Event<()>) in
                print(event)
        }
        
        // UITextView，单独的点击事件
        let textView = UITextView()
        textView.rx.didBeginEditing.subscribe { (event) in
            print(event)
        }
        
    }
    
    func uibutton() {
        let btn = UIButton()
        
        btn.rx.tap.subscribe { (event) in
            print("点击按钮")
        }
        
        
        Observable<Int>
            .interval(1, scheduler: MainScheduler.instance)
            .map { "当前时间\($0)" }
            .bind(to: btn.rx.title(for: .normal)).disposed(by: disposeBag)
        
        
        
    }
    
    func uiswitch() {
        
        let uiSwitch = UISwitch()
        
        uiSwitch.rx.isOn.asDriver().drive(onNext: { (value) in
            print(value)
            }).disposed(by: disposeBag)
        
    }
    
    func gesture() {
        
        let gesture = UITapGestureRecognizer()
        gesture.rx.event.subscribe { (event: Event<UITapGestureRecognizer>) in
            
        }.disposed(by: disposeBag)
    }
    
}
