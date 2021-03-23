//
//  ObservableViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/6.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift

/*
 
 1、Observable：ObservalType。该协议一个重要方法就是.subscribe订阅。
 非常重要，理解为可观察队列。其作用是可以产生一系列Event（事件），即会随着时间的推移不停的发送Event（是一个枚举，有next、error、completed三种类型）。注意可以多次subscribe，并且只要订阅就能收到Observable发送的Event。

 其创建方式：
 Observable.just(e) //特点是，有一个默认初始值。
 Observable.of(e,e,e...) //特点是，有多个默认值。
 Observable.from([e,e...]) // 有一个默认数组。然后会将数组中，单个元素一个一个组装成event发出。
 Observable.range(start: 1, count: 5) // 类似.of(1, 2, 3, 4, 5)。注意其参数必须为int。
 Observable.repeatElement(e) // 一直不停的发送e，不会停止。
 Observable.generate   // 通过制定条件生成固定event。initialState： 初始值。contition：当条件为false，就结束。iterate：对值进行操作。
 Observable.create // 通过block创建Observable。内部生成Observer，observer通过.next .complement发送event。
 Observable.interval // 相当于一个定时器。
 Observable.timer     // 相当于延迟多长时间执行。有两种方法：1、延时多长时间执行一次。2、执行多次

 Observable.empty()  // 只会发出complement event。
 Observable.error()   // 只会发出 error event。
 Observable.never()  // 永远不会发出event。

 
 */
class ObservableViewController: SSBaseViewController {

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()


        forObservable()
        
       
        
        
    }
    
    private func forObservable() {
        
        print("\nof---------------")
        let ofO = Observable.of(1, 2, 3,4)
        ofO.subscribe { (value) in
            print("of---:\(value)")
        } onError: { (error) in
            print(error)
        } onCompleted: {
            print("of---: complement")
        }.disposed(by: disposeBag)

        print("\njust-------------")
        let justO = Observable.just(3)
        justO.subscribe { (value) in
            print("just---:\(value)")
        } onCompleted: {
            print("just---: complement")
        }.disposed(by: disposeBag)
        
        print("\nfrom-------------")
        let fromO = Observable.from([1,2,3,4])
        fromO.subscribe { (value) in
            print("from---:\(value)")
        } onCompleted: {
            print("from---: complement")
        }.disposed(by: disposeBag)
        
        print("\nrange-------------")
        let range = Observable.range(start: 1, count: 5)
        range.subscribe { (value) in
            print("range---:\(value)")
        } onCompleted: {
            print("range---: complement")
        }.disposed(by: disposeBag)
        
//        print("\nrepeatElement-------------")
//        var repeatCount = 1
//        let repeatE = Observable.repeatElement(1)
//        repeatE.subscribe { (value) in
//            print("repeatElement---:\(value)")
//            repeatCount += 1
//        } onCompleted: {
//            print("repeatElement---: complement")
//        }.disposed(by: disposeBag)
        
        
        print("\ngenerate-------------")
        let generate = Observable<Int>.generate(initialState: 0) { (value) -> Bool in
            return value < 10
        } iterate: { (value) -> Int in
            return value + 2
        }
        generate.subscribe { (value) in
            print("generate---:\(value)")
        } onCompleted: {
            print("generate---: complement")
        }.disposed(by: disposeBag)
        
        
        print("\ncreate-------------")
        let create = Observable<Int>.create { (observer) -> Disposable in
            observer.onNext(1)
            observer.onNext(12)
            observer.onCompleted()
            return Disposables.create()
        }
        create.subscribe { (value) in
            print("create---:\(value)")
        } onCompleted: {
            print("create---: complement")
        }.disposed(by: disposeBag)
        
        print("\ninterval------------")
        //let interval = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.asyncInstance)
        let timer = Observable<Int>.timer(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)

        timer.subscribe { (value) in
            print("interval---:\(value)\(Thread.current)")
        } onCompleted: {
            print("interval---: complement")
        }.disposed(by: disposeBag)
         
        
        
        print("\ndeffer-------------")
        var isOdd = true
        let deffer = Observable<Int>.deferred { () -> Observable<Int> in
            isOdd = !isOdd
            if isOdd {
                return Observable.of(2, 4, 6, 8, 10)
            }else {
                return Observable.of(1, 3, 5, 7, 9)
            }
        }
        deffer.subscribe { (value) in
            print("deffer---:\(value)")
        } onCompleted: {
            print("deffer---: complement")
        }.disposed(by: disposeBag)
        
        deffer.subscribe { (value) in
            print("deffer1---:\(value)")
        } onCompleted: {
            print("deffer1---: complement")
        }.disposed(by: disposeBag)
        
        print("\nempty-------------")
        let empty = Observable<Any>.empty()
        empty.subscribe { (value) in
            print("empty---:\(value)")
        } onCompleted: {
            print("empty---: complement")
        }.disposed(by: disposeBag)
        
        print("\nerror-------------")
        let error = Observable<NSError>.error(NSError(domain: "错误", code: 100, userInfo: nil))
        error.subscribe { (value) in
            print("error---:\(value)")
        } onError: { (error) in
            print("error---:\(error)")
        }onCompleted: {
            print("error---: complement")
        }.disposed(by: disposeBag)
        
        print("\nnever-------------")
        let never = Observable<Any>.never()
        never.subscribe { (value) in
            print("never---:\(value)")
        } onError: { (error) in
            print("never---:\(error)")
        }onCompleted: {
            print("never---: complement")
        }.disposed(by: disposeBag)
    }
   

}
