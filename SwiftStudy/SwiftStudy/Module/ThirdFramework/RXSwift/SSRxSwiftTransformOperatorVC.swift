//
//  SSRxSwiftTransformOperatorVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/15.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SSRxSwiftTransformOperatorVC: QMUICommonViewController {

    
    private let disposeBag = DisposeBag()
    override func initSubviews() {
    
        //buffer()
        //map()
        //flatMap()
        
        //contactMap()
    
        //scan()
        
        groupBy()
    }

}

extension SSRxSwiftTransformOperatorVC {
    
    func buffer() {
        
//        buffer 方法作用是缓冲组合，第一个参数是缓冲时间，第二个参数是缓冲个数，第三个参数是线程。
//        该方法简单来说就是缓存 Observable 中发出的新元素，当元素达到某个数量，或者经过了特定的时间，它就会将这个元素集合发送出来。
        let buffer = PublishSubject<String>()
        buffer
            .buffer(timeSpan: 5, count: 3, scheduler: MainScheduler.instance)
            .subscribe { (event: Event<[String]>) in
                print(event.element)
        }.disposed(by: disposeBag)
        
        buffer.onNext("A")
        buffer.onNext("B")
        buffer.onNext("C")
        buffer.onNext("D")
        buffer.onNext("E")
        buffer.onNext("F")
    }
    
    func window() {
        
        // window和buffer很像，但是返回的是，Observable对象。
        let window = PublishSubject<String>()
        window
            .window(timeSpan: 5.0, count: 3, scheduler: MainScheduler.instance)
            .subscribe { (event: Event<Observable<String>>) in
                print(event.element)
        }.disposed(by: disposeBag)
        
    }
    
    // map 映射
    // 将接受的数据进行处理
    func map() {
        
        let behavior = BehaviorSubject<String>.init(value: "Behavior Subject")
        behavior
            .map { "这是映射的数据\($0)" }
            .subscribe { (value) in
                print(value)
        }.disposed(by: disposeBag)
    }
    
    // flatMap进行降维
    func flatMap() {
        
        let replaySubject = ReplaySubject<String>.createUnbounded()
        
        let behaviorRelay = BehaviorRelay<ReplaySubject>.init(value: replaySubject)
        behaviorRelay.flatMap { $0 }
            .subscribe { (event: Event<String>) in
                print(event.element)
        }.disposed(by: disposeBag)
        
        replaySubject.onNext("ReplaySubject")
        
    }
    
    // ContactMap只接受最新的一个
    func contactMap() {
        
        let behavior1 = BehaviorSubject<String>(value: "A")
        let behavior2 = BehaviorSubject<String>(value: "1")
        
        let behaviorRelay = BehaviorRelay<BehaviorSubject>(value: behavior1)
        behaviorRelay.concatMap { $0 }
            .subscribe { (event: Event<String>) in
                print(event.element)
        }.disposed(by: disposeBag)
        
        behavior1.onNext("B")
        behaviorRelay.accept(behavior2)
        behavior2.onNext("2")
        behavior1.onNext("C")
        behavior2.onNext("3")
        behavior1.onCompleted() // 只有第一个completed后，才能接受下一个序列
        /*
         输出结果：
         A
         B
         C
         3
         所以当第一subject1事件完成后，才会接受第二个事件。
         */
    }
    
    // 给一个初始值，然后将初始值递增
    func scan() {
        
        Observable<Int>
            .from([1, 2, 3, 4])
            .scan(10) { (sed, value) -> Int in
                return sed + value
        }.subscribe(onNext: { (value) in
            print(value)
            }).disposed(by: disposeBag)
    }
    
    // groupBy 能够将序列进行分组。
    func groupBy() {
        
        Observable<Int>.of(1, 2, 3, 4)
            .groupBy { (item: Int) -> String in
                return (item%2 == 0) ? "偶数":"奇数"
        }.subscribe { (evnet: Event<GroupedObservable<String, Int>>) in
            guard let group = evnet.element else {
                return
            }
            
            group.asObservable().subscribe { (event) in
                print(event.element, group.key)
            }.disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
}
