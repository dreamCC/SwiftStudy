//
//  SSRxSwiftFilterOperatorVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/15.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift

/*
 Observable、Observer和Subscript的关系。
 
 Observable（可以订阅的xxx），相当于楚天都市报
 Observer（观察者），相当于记者
 Subscript（订阅者），相当于读者。
 
 所以Observable和Observer一定是成对出现的，Observer来监听事件的变化，通过.onNext来发送事件，订阅者就能够监听到事件
 
 */
class SSRxSwiftFilterOperatorVC: QMUICommonViewController {

    private let disposeBag = DisposeBag()
    override func initSubviews() {
     
        //filter()
        //distinctUntilChanged()
        //single()
        
        //elementAt()
        //ignorElements()
        take()
        //skip()
    }

}

extension SSRxSwiftFilterOperatorVC {
    
    // 进行过滤
    func filter() {
        
        Observable<Int>.from([1, 2, 3, 4, 5])
            .filter { $0 > 3 }
            .subscribe(onNext: { (value) in
                print(value)
            }).dispose()
        
    }
    
    
    // 用来进行去重操作
    // 当前后两个值相同，那么就会去重
    func distinctUntilChanged() {
     
        Observable<Int>.from([1, 2, 2, 2, 3, 3, 1, 4, 4 ,1])
            .distinctUntilChanged()
            .subscribe { (event: Event<Int>) in
                print(event.element)
        }.disposed(by: disposeBag)
        
    }
    
    // 只发送一次事件，或者满足条件的一次事件
    func single() {
        
        Observable<Int>.of(1, 2, 3)
        .single()
            .subscribe { (event) in
                print(event)
        }.disposed(by: disposeBag)
        
        Observable<Int>.from([1, 2, 3, 4, 5])
            .single { (value) -> Bool in
                return value > 2
        }.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
    }
    
    
    // 输出指定事件
    func elementAt() {
        
        Observable<Int>.of(1, 2, 3, 2)
            .elementAt(2)
            .subscribe { (event: Event<Int>) in
                print(event.element)
        }.disposed(by: disposeBag)
        
    }
    
    // 忽略掉所有的元素, 只会接受completed和error事件
    func ignorElements() {
        
        Observable<Int>.of(1, 2, 3)
            .ignoreElements()
            .subscribe { (event: CompletableEvent) in
                print(event)
        }.disposed(by: disposeBag)
        
    }
    
    
    // take 只能发送指定的事件个数
    // takelast 发送最后一个
    func take() {
        
        Observable<Int>
            .from([2, 3, 4, 5])
            .take(2)
            .subscribe { (event) in
                print(event.element)
        }.disposed(by: disposeBag)
        
        
        print("takeLast---------------------")
        Observable<Int>
            .of(2, 3 ,4 ,5)
            .takeLast(2)
            .subscribe { (event) in
                print(event.element)
        }.disposed(by: disposeBag)
        
        print("takeWhile---------------------")
        // 会从第一个开始判断，如果不满足，就会停止发送事件。
        Observable<Int>
            .of(2, 3, 4, 5)
            .takeWhile { (value) -> Bool in
                print(value, "-------value")
                return value < 3
        }.subscribe { (event: Event<Int>) in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    // 跳过多少事件
    func skip() {
        
        Observable<Int>
            .from([2, 3, 4, 5])
            .skip(2)
            .subscribe { (event) in
                print(event)
        }
    }
}
