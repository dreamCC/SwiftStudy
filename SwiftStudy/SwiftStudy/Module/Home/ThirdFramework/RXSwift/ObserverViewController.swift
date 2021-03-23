//
//  ObserverViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/6.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
/*
 
 2、Observer: ObserverType 观察者。主要是用来监听Observable发出的Event，当Observable发出Event后，Observer 监听者需要做出什么操作。 遵循该协议的有AnyObserver和Binder。
 ObserverType。协议的重要方法.on .next .error .complement。因此我们会联想Observable内部的实现，可能也是通过创建Observer，然后通过.on发送Event。
 AnyObserver,可以接受到任意Event。
 Binder，相比AnyObserver，不会处理error，和complement，而且，能够指定Schedule。
 属于RxCocoa的内容。更适合处理UI。如果binder error将会报错。


 public func bind<Observer>(to observers: Observer...) -> RxSwift.Disposable where Observer : RxSwift.ObserverType, Observer.Element == Self.Element?
 注意这种写法，因为ObservableType： ObservableConvertibleType是泛型，而Observer也是泛型，后面where就是对泛型的限制。
 
 */
class ObserverViewController: SSBaseViewController {

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        anyObserver()
        //binder()
        //rxBinder()
        //customBinder()
        
    }

    
}

extension ObserverViewController {
    
    // 这种方法相当于我们直接通过闭包的形式处理了监听到的事件Event。
    private func defaultObserver() {
        
        let observable = Observable<Int>.of(1, 2, 3, 4, 5)
        observable.subscribe { (value) in
            print("监听到：\(value)")
        }.disposed(by: disposeBag)

    }
    
    
    private func anyObserver() {
        
        let anyObserver = AnyObserver<Int> { (event: Event<Int>) in
            print(event)
        }
        print("onNext----------------------")
        anyObserver.onNext(1)
        anyObserver.onNext(2)
        anyObserver.onError(NSError(domain: "错误", code: 100, userInfo: nil))
        anyObserver.onNext(1)
        anyObserver.onNext(2)
        
        print("subscribe----------------------")
        // 通过subscribe，订阅
        Observable<Int>.of(1, 2, 3, 4).subscribe(anyObserver).disposed(by: disposeBag)
        
        print("bind----------------------")
        // 通过bind，绑定
        Observable<Int>.of(1,2 ,3 ,4).bind(to: anyObserver).disposed(by: disposeBag)
    }
    
    
    private func binder() {
        
        let binder = Binder<String>(self.desLab) { (lab, value) in
            lab.text = "接收到值：\(value)"
            print(value, lab)
        }
        binder.onNext("hello")
        //binder.onError(NSError(domain: "Binder error", code: 100, userInfo: nil))
        binder.onCompleted()
        binder.onNext("world")

        //Observable<String>.of("hello", "world").bind(to: binder).disposed(by: disposeBag)
        
    }
    
    private func rxBinder() {
        
        let observable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler())
        observable
            .map({ "当前时间: \($0) s" })
            .bind(to: desLab.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    private func customBinder() {
        
        desLab.text = "custom binder"
        let observable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler())
        observable.map({ CGFloat($0) })
            .bind(to: desLab.rx.fontSize)
            .disposed(by: disposeBag)
    }
}


// 自定义binder属性。
extension Reactive where Base: UILabel {
    
    var fontSize: Binder<CGFloat> {
        return Binder<CGFloat>(base) { (lab, fontSize) in
            base.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

