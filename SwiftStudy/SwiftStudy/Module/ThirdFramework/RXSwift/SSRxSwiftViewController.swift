//
//  SSRxSwiftViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/9.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SSRxSwiftViewController: QMUICommonViewController {
    @IBOutlet weak var timeLab: UILabel!
    
    private let disposeBag = DisposeBag()
    override func initSubviews() {
        //subject()
        //otherHandle()
        //observer()
        bindTo()
    }

}

enum RxCusError: Error {
    case errorA
    case errorB
}

extension SSRxSwiftViewController {
    
    func observer() {
        // 从来不执行的Observable
        let never =  Observable<String>.never()
        never.subscribe { (evetn) in
            
        }.disposed(by: disposeBag)
        
        print("empyt---------------------------------")
        // empyt只会执行complete
        let empty = Observable<String>.empty()
        empty.subscribe { (event: Event<String>) in
            print("执行 complement")
        }.disposed(by: disposeBag)
        
        print("just---------------------------------")
        // just。只会执行一次。
        let just = Observable<String>.just("hello")
        just.subscribe { (event: Event<String>) in
            print(event.element)
        }.disposed(by: disposeBag)
        
        print("of---------------------------------")
        // of
        let of = Observable<String>.of("a","b","c")
        of.subscribe(onNext: { (value) in
            print(value)
        }).disposed(by: disposeBag)
        
        print("create---------------------------------")
        // create
        let create = Observable<String>.create { (obj :AnyObserver<String>) -> Disposable in
            
            obj.onNext("hello")
            obj.onNext("world")
            obj.onCompleted()
            return Disposables.create()
        }
        create.subscribe { (value) in
            print(value)
        }.disposed(by: disposeBag)
        
        print("range---------------------------------")
        // Range
        let range  = Observable<Int>.range(start: 1, count: 10)
        range.subscribe { (event) in
            print(event.element)
        }.disposed(by: disposeBag)
        
        print("repeat---------------------------------")
        let repeatO = Observable<String>.repeatElement("hello")
        repeatO
            .take(10)
            .subscribe { (event) in
                print(event.element)
        }.disposed(by: disposeBag)
        
        print("internal---------------------------------")
        // 没一秒发送一次。相当于定时器
//        let internalO = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        internalO.subscribe{ (value) in
//            print(value)
//        }.disposed(by: disposeBag)
       
        print("from---------------------------------")
        let fromO = Observable<String>.from(["a", "b", "c"])
        fromO.subscribe { value in
            print(value.element)
        }.disposed(by: disposeBag)
        
        
        
        print("error---------------------------------")
        let errorO = Observable<String>.error(RxCusError.errorA)
        errorO.subscribe { (value) in
            print(value)
        }.disposed(by: disposeBag)
        
        // do on 用来监听方法
       
    }
    
    
    func subject() {
        print("PublishSubject-----------------------------------------------")
        // PublishSubject，订阅者只能接受，订阅之后发出的事件
        let pubSubject = PublishSubject<String>()
        
        pubSubject.onNext("subscribe 订阅开始的事件")
        pubSubject.subscribe { (evnet: Event<String>) in
            print(evnet.element)
        }.disposed(by: disposeBag)
        pubSubject.onNext("subscribe 订阅后的事件")
        
        // 当然也可以通过，create来创建，类似Observable
        /*
        let pubSubject2 = PublishSubject<String>.create { (observer: AnyObserver<String>) -> Disposable in
            observer.onNext("create on next1")
            observer.onNext("create on next2")

            return Disposables.create()
        }
        pubSubject2.subscribe { (event) in
            print(event.element)
        }.disposed(by: disposeBag)
        */
        
        /*
         输出结果：
         Optional("subscribe 订阅后的事件")
         */
        
        print("ReplaySubject-----------------------------------------------")
        // ReplaySubject，订阅者可以接受订阅之前的事件和订阅之后的事件
        // bufferSize表示，订阅前缓存的个数。
        // 我们可以使用 ReplaySubject.createUnbounded()来创建无边界的Subject
        let replaySub = ReplaySubject<String>.create(bufferSize: 2)
        replaySub.onNext("ReplaySubject 订阅前1")
        replaySub.onNext("ReplaySubject 订阅前2")
        replaySub.onNext("ReplaySubject 订阅前3")
        replaySub.subscribe { (value) in
            print(value)
        }.disposed(by: disposeBag)
        replaySub.onNext("ReplaySubject 订阅后1")
        replaySub.onNext("ReplaySubject 订阅后2")
        replaySub.onNext("ReplaySubject 订阅后3")

        /*
         输出结果：
         next(ReplaySubject 订阅前2)
         next(ReplaySubject 订阅前3)
         next(ReplaySubject 订阅后1)
         next(ReplaySubject 订阅后2)
         next(ReplaySubject 订阅后3)

         */
        
        print("BehaviorSubject-----------------------------------------------")
        // BehaviorSubject ，订阅者可以接受订阅之前的最后一个事件
        let behaviorSubject = BehaviorSubject<String>(value: "a")
        behaviorSubject.onNext("b")
        behaviorSubject.onNext("c")
        behaviorSubject.subscribe { (event) in
            print(event.element)
        }.disposed(by: disposeBag)
        behaviorSubject.onNext("e")
        behaviorSubject.onNext("f")
        /*
         输出结果：
         Optional("c")
         Optional("e")
         Optional("f")
         */

        print("BehaviorRelay-----------------------------------------------")
        let behaviorReplay = BehaviorRelay<String>.init(value: "初始化")
        behaviorReplay.accept("订阅1")
        behaviorReplay.accept("订阅2")
        behaviorReplay.asObservable().subscribe { (event) in
            print(event.element)
        }.disposed(by: disposeBag)
        behaviorReplay.accept("订阅3")
        
        print("AsyncSubject-----------------------------------------------")
        let asyncSubject = AsyncSubject<String>.init()
        asyncSubject.onNext("第一次")
        asyncSubject.onNext("第2次")
        asyncSubject.onNext("第3次")
        asyncSubject.subscribe { (event: Event<String>) in
            print(event.element)
        }.disposed(by: disposeBag)
        asyncSubject.onNext("第4次")
        asyncSubject.onNext("第3次")
        // 不发送complement，则不会接受订阅
        asyncSubject.onCompleted()

        
        
        print("ControlProperty-----------------------------------------------")
        
        
        

    }
    
    func otherHandle() {
        
        print("map---------------------------------")
        Observable
            .of(1, 2, 3)
            .map({$0*$0})
            .subscribe { (event) in
                print(event.element)
        }.disposed(by: disposeBag)
        
    }
    
    // 释放的两种方式。
    // .dispose() 直接销毁，但是后面就不能再次使用Observable对象。
    // .disposed(by: disposeBag) 最常用的方法，用于销毁，当页面销毁的时候销毁，相当于自动释放池。
    func disposeFunc() {
        let subject = BehaviorSubject<String>(value: "a")
        subject.subscribe { (event: Event<String>) in
            print(event.element)
        }.disposed(by: disposeBag)
    }

    func bindTo() {
     
        
        let observer = AnyObserver<String>.init { (event: Event<String>) in
            
            switch event {
            case .next(let value):
                self.timeLab.text = value
            case .completed:
                self.timeLab.text = "completed"
            default: break
            }
            self.timeLab.sizeToFit()
        }
        
        
        
        // 相当于定时器
        let internalO = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        internalO
//            .map { "当前的时间：\($0)s" }
//            .bind(to: observer)
//            .disposed(by: disposeBag)
        
        
        let binder = Binder<String>.init(timeLab) { (lab, value) in
            lab.text = value
        }
//
//
//        internalO
//            .map { "当前时间： \($0)s" }
//            .bind(to: binder)
//            .disposed(by: disposeBag)
        
        
        
    }
    
}

// MARK:---- ui扩展。 对已有UI进行扩展
extension Reactive where Base: UILabel {
    
    var fontSize: Binder<CGFloat> {
        return Binder<CGFloat>(self.base) { lab, value in
            lab.font = UIFont.systemFont(ofSize: value)
        }
    }
}


extension SSRxSwiftViewController {
    
    
}

