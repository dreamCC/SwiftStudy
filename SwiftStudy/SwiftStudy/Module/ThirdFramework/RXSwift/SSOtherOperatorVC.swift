//
//  SSOtherOperatorVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/16.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift

class SSOtherOperatorVC: QMUICommonViewController {

    
    private let disposeBag = DisposeBag()
    override func initSubviews() {
        //delay()
        //delaySubscription()
        //materialize()
        //dematerialize()
        debug()
    }

}

extension SSOtherOperatorVC {
    
    // 延时
    func delay() {
        
        Observable<Int>
            .of(1, 2, 3)
            .delay(5, scheduler: MainScheduler.instance)
            .subscribe { (evnet: Event<Int>) in
                print(evnet.element)
        }.disposed(by: disposeBag)

    }


    // 延时订阅
    func delaySubscription() {
        
        Observable<Int>.just(1)
            .delaySubscription(5, scheduler: MainScheduler.instance)
            .subscribe { (event: Event<Int>) in
                print(event.element)
        }.disposed(by: disposeBag)
    }
    
    // materialize 将元素转换成事件
    func materialize() {
        
        Observable<Int>.from([1, 2, 3, 4])
            .materialize()
            .subscribe({ (event: Event<Event<Int>>) in
                print(event.element)
            })
        .disposed(by: disposeBag)
        
    }
    
    // 和materalize刚好相反
    func dematerialize() {
        
        Observable<Int>.from([1, 2, 3, 4])
            .materialize()
            .dematerialize()
            .subscribe { print($0) }
        .disposed(by: disposeBag)
        
    }
    
    // 如果在规定的事件内没有发送事件，则发送error
    func timeOut() {
        
    }
    
    // 错误处理。 retry 重试次数。
    func retry() {
        
    }
    
    // debug 调试
    func debug() {
        
        Observable<Int>.of(1, 2)
            .debug(" 调试 ", trimOutput: true)
            .subscribe { (event) in
                print(event)
        }.disposed(by: disposeBag)
    }
}

