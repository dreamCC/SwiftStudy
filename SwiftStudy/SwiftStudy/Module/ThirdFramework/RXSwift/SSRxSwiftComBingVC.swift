//
//  SSRxSwiftComBingVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/15.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift

class SSRxSwiftComBingVC: QMUICommonViewController {

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        //startWith()
        
        //toArray()
        
        //reduce()
        
        contact()
    }
    


}

extension SSRxSwiftComBingVC {
    
    // 以什么开始，即插入数据
    func startWith() {
        
        Observable<Int>
            .of(1, 2, 3)
            .startWith(12)
            .subscribe { (event: Event<Int>) in
            print(event.element)
        }.disposed(by: disposeBag)
        
    }
    

    // 合并, 会将两条事件线合并成一条。
    func merge() {
        
        let disposeBag = DisposeBag()
                 
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
         
        Observable.of(subject1, subject2)
            .merge()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        subject1.onNext(20)
        subject1.onNext(40)
        subject1.onNext(60)
        subject2.onNext(1)
        subject1.onNext(80)
        subject1.onNext(100)
        subject2.onNext(1)
        
    }
    
    // 将两条事件线压缩成一条。
    func zip() {
        
        let disposeBag = DisposeBag()
                 
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
         
        Observable.zip(subject1, subject2) {
            "\($0)\($1)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        subject1.onNext(1)
        subject2.onNext("A")
        subject1.onNext(2)
        subject2.onNext("B")
        subject2.onNext("C")
        subject2.onNext("D")
        subject1.onNext(3)
        subject1.onNext(4)
        subject1.onNext(5)
        
        /*
         1A
         2B
         3C
         4D
         */
    }
    
    
    // 转换成一个数组
    func toArray() {
        
        Observable<Int>
            .of(1, 2, 3, 4)
            .toArray()
            .subscribe(onSuccess: { (value: [Int]) in
                print(value)
            })
            .disposed(by: disposeBag)
        
    }
    
    // reduce， 通过传入的操作符进行操作。 类似Array里面的reduce
    func reduce() {
        
        Observable<Int>
            .from([1, 2, 3, 4])
            .reduce(10, accumulator: +)
            .subscribe { (event: Event<Int>) in
                print(event.element)
        }.disposed(by: disposeBag)
    }
    
    // 将两个序列链接在一起
    // 并且当第一个序列发送onCompleted后，第二个序列才开始接受事件。
    func contact() {
        
        let publish1 = PublishSubject<String>()
        let publish2 = PublishSubject<String>()
        
        publish1
            .asObserver()
            .concat(publish2)
            .subscribe(onNext: { (value) in
                print(value)
            }).disposed(by: disposeBag)
        
        
        publish1.onNext("A")
        publish1.onNext("B")
        publish1.onNext("C")
        publish1.onCompleted()
        publish2.onNext("1")
        publish2.onNext("2")
        publish2.onNext("3")
        publish2.onNext("4")

    }
}
