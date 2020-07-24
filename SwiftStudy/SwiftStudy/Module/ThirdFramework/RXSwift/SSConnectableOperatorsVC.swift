//
//  SSConnectableOperatorsVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/16.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/*
 可连接序列（Connectable Observable）：
 1、可连接序列不同于其它序列，有订阅的时候不会立即发送消息，只有当connect()之后才能发送值。
 2、可连接的序列可以让所有的订阅者订阅后，才开始发送消息事件，从而保证所有订阅者都能收到消息。
 
 */

class SSConnectableOperatorsVC: QMUICommonViewController {

    private let disposeBag = DisposeBag()
    override func initSubviews() {
        //publish()
        replay()
    }

}

extension SSConnectableOperatorsVC {
    
    // publish会将一个序列转换成一个Connectable Observable。
    // ConnectableObservableType继承ObservableType类型。
    func publish() {
        
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()
        interval.take(5).subscribe { (event: Event<Int>) in
            print(event.element)
        }.disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            interval.connect().disposed(by: self.disposeBag)
        }
    }
    
    // replay 同样会将Observable转换成一个ConnectableObservable
    // replay 有个bufferSize，即可以接受订阅前发送的事件。
    func replay() {
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).replay(5)
        interval.take(5).subscribe { (event) in
            print(event.element)
        }.disposed(by: disposeBag)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            interval.connect().disposed(by: self.disposeBag)
        }
    }
    
}
