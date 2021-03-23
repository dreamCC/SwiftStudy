//
//  SubjectsViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/6.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift

/*
 3、Subject 即是Observer，也是Observable。
 特点是当发送complement、error，subject就会终结，不发出onNext 。

 有四种：
 PublishSubject， 特点：subscribe前，调用的onNext不会成功。

 BehaviorSubject， 特点：有一个默认值，subscribe前，调用的onNext只会存在最后一个。

 ReplaySubject， 特点：会有一个bufferSize，subscribe前，调用的onNext只会存在bufferSize个。

 Variable是对BehaviorSubject的封装，但是目前RxSwift已经遗弃了Variable。
 
 */
class SubjectsViewController: SSBaseViewController {

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

//        publishSubject()
//        behaviorSubject()
        replaySubject()
    }
    
    private func publishSubject() {
        
        let publishSubject = PublishSubject<String>()
        publishSubject.onNext("-hello")
        publishSubject.onNext("-world")

        publishSubject.subscribe { (value) in
            print("接收到值:" + value)
        } onError: { (error) in
            print(error)
        } onCompleted: {
            print("publishSubject----complement")
        }.disposed(by: disposeBag)
        
        publishSubject.onNext("hello")
        publishSubject.onNext("world")
        publishSubject.onError(NSError(domain: "publish error", code: 100, userInfo: nil))
        publishSubject.onCompleted()
        
        // 不会受到这个event
        publishSubject.onNext("hello")
        

    }
    
    private func behaviorSubject() {
        
        let behaviorSubject = BehaviorSubject<String>(value: "默认值")
        behaviorSubject.onNext("-hello")
        behaviorSubject.onNext("-world")
        behaviorSubject.subscribe { (value) in
            print("接收到值:" + value)
        } onError: { (error) in
            print(error)
        } onCompleted: {
            print("publishSubject----complement")
        }.disposed(by: disposeBag)
        
        behaviorSubject.onNext("hello")
        behaviorSubject.onNext("world")
        behaviorSubject.onError(NSError(domain: "publish error", code: 100, userInfo: nil))
        behaviorSubject.onCompleted()
        
        // 不会收到这个event
        behaviorSubject.onNext("hello")

    }
    
    private func replaySubject() {
        
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
        
        replaySubject.onNext("-hello")
        replaySubject.onNext("-world")
        replaySubject.onNext("-enha")

        replaySubject.subscribe { (value) in
            print("接收到值:" + value)
        } onError: { (error) in
            print(error)
        } onCompleted: {
            print("publishSubject----complement")
        }.disposed(by: disposeBag)

        replaySubject.onNext("hello")
        replaySubject.onNext("world")
        replaySubject.onNext("enha")
        replaySubject.onError(NSError(domain: "publish error", code: 100, userInfo: nil))
        replaySubject.onCompleted()
        
        replaySubject.onNext("enha")
    }
    
   
    
}
