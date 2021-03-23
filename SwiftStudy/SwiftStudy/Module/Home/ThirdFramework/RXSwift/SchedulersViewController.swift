//
//  SchedulersViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/10.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift

/*
 Observable<Int>.create { (observer) -> Disposable in
     print("subScribing code", Thread.current)
     observer.onNext(1)
     sleep(1)
     observer.onNext(2)
     return Disposables.create()
 }.subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
  .observeOn(MainScheduler.instance)
  .subscribe { (value) in
     print("observering code", value, Thread.current)
 }.disposed(by: disposeBag)
 
 这块代码很好的说明了，subscribeOn和observerOn的工作区域。
 
 我们同样要理解Observable和Observer的作用。
 Observerable用来产生event。前提是当被subscribe的时候。
 
 Observer用来监听event。
 
 */
class SchedulersViewController: SSBaseViewController {

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func currentThread(_ sender: Any) {
        
        DispatchQueue.global().async {
            Observable<Int>.of(1, 2, 3)
                .subscribeOn(CurrentThreadScheduler.instance)
                .subscribe { (value) in
                    print(value, Thread.current)
                } onCompleted: {
                    print("completable", Thread.current)
                }.disposed(by: self.disposeBag)

        }
        
    }
    
    @IBAction func main(_ sender: Any) {
        
        Observable<Int>.create { (observer) -> Disposable in
            print("subScribing code", Thread.current)
            observer.onNext(1)
            sleep(1)
            observer.onNext(2)
            return Disposables.create()
        }.subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .default))
         .observeOn(MainScheduler.instance)
         .subscribe { (value) in
            print("observering code", value, Thread.current)
        }.disposed(by: disposeBag)

        
    }
    
    @IBAction func serialDispathQueue(_ sender: Any) {
        
        let serialQueue = SerialDispatchQueueScheduler(qos: .default)
        
        Observable<Int>.of(4, 5, 6)
            .subscribeOn(serialQueue)
            .subscribe { (value) in
                print("thread-1：", value, Thread.current)
            } onCompleted: {
                print("thread-1:", "completable", Thread.current)
            }.disposed(by: disposeBag)
        
        Observable<Int>.of(7, 8, 9)
            .subscribeOn(serialQueue)
            .subscribe { (value) in
                print("thread-2:",value, Thread.current)
            } onCompleted: {
                print("thread-2:", "completable", Thread.current)
            }.disposed(by: disposeBag)
    }
    
    @IBAction func concurrentDispathQueue(_ sender: Any) {
        
        let concurrent = ConcurrentDispatchQueueScheduler(qos: .default)
        
        Observable<Int>.of(4, 5, 6)
            .subscribeOn(concurrent)
            .subscribe { (value) in
                print("thread-1：", value, Thread.current)
            } onCompleted: {
                print("thread-1:", "completable", Thread.current)
            }.disposed(by: self.disposeBag)
        
        Observable<Int>.of(7, 8, 9)
            .subscribeOn(concurrent)
            .observeOn(MainScheduler.instance)
            .subscribe { (value) in
                print("thread-2:",value, Thread.current)
            } onCompleted: {
                print("thread-2:", "completable", Thread.current)
            }.disposed(by: disposeBag)
        
    }
    
    
    @IBAction func operationQueue(_ sender: Any) {
        
    
    }
}
