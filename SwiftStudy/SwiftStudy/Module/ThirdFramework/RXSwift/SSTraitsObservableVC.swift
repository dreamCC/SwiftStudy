//
//  SSTraitsObservableVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/16.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

/*
 RxSwift除了基本的Observable序列外，还提供了一些特征序列Trait Observable。
 如：
 Single、Completable、MayBe、Driver、ControlProperty、ControlEvent。
 我们可以将Traits看做是Observable的一些特别版本。区别：
 1、Observable是可以用于任意上下文环境中的通用序列。
 2、Traits可以更加准确的描述序列。同时他们还为我们提供上下文含义、语法糖，让我们更加优雅的的方式书写代码。
 
 查看源码，我们发现，Single、Completable、MayBe都是PrimitiveSequence。是存在RxSwift中。
 
 Driver和ControllerEvent是存在RxCocoa中的，主要是服务ui。
 查看源码，我们发现Driver其实就是SharedSequence。
 
 ControllerEvent、ControlProperty都是结构体。 都是Observable序列。
 */

enum SSTraitsError: Error {
    case Single(reason: String)
    case Completable(reason: String)
    case MayBe(_ reason: String)
    
    var reason: String {
        switch self {
        case .Completable(reason: let reason):
            return reason
        case .Single(reason: let reason):
            return reason
        case .MayBe(let reason):
            return reason
        }
    }
    
}

class SSTraitsObservableVC: QMUICommonViewController {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var inputLab: UILabel!
    
    private let disposeBag = DisposeBag()
    override func initSubviews() {
     
        //single()
        //asSingle()
        //completable()
        //mayBe()
        //asMayBe()
        driver()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
//        guard let url = URL(string: "ccbmobilebank://") else {
//            return
//        }
//        UIApplication.shared.open(url, options: [.universalLinksOnly : false], completionHandler: nil)
    }
}



extension SSTraitsObservableVC {
    
    /*
     Single只能发送一个事件，或者发送一个error。即要么成功， 要么失败
     
     Single 比较常见的例子就是执行 HTTP 请求，然后返回一个应答或错误。不过我们也可以用 Single 来描述任何只有一个元素的序列。
     
     Single对于的event是Rxswfit为我们提供的SingleEvent
     public enum SingleEvent<Element> {
         case success(Element)
         case error(Swift.Error)
     }
     */
    func single() {
        
        networkForPlayList(channel: "0")
            .subscribe(onSuccess: { (response: [String : Any]) in
                print(response)
            }) { (error: Error) in
                print(error)
        }.disposed(by: disposeBag)
        
        
    }
    
    // asSingle可以将一个普通的Observable转换成一个SingObservable
    // asSingle的前提是Observable只有一个elment。否则会报错。
    func asSingle() {
        
        Observable<Int>.from([2])
            .asSingle()
            .subscribe { print($0) }.disposed(by: disposeBag)
        
    }
    
    
    /*
     Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，
     它要么只能产生一个 completed 事件，或者产生一个 error 事件。
     
     public enum CompletableEvent {
         case error(Swift.Error)
         case completed
     }
     
     */
    func completable() {
        cachLocal().subscribe(onCompleted: {
            print("onCompleted----")
        }) { (error: Error) in
            guard let error = error as? SSTraitsError  else  {
                return
            }
            print(error.reason)
        }.disposed(by: disposeBag)
    }

    
    /*
     MayBe会发出一个元素或者一个completed事件或者一个error事件
     
     public enum MaybeEvent<Element> {
         case success(Element)
         case error(Swift.Error)
         case completed
     }
     */
    func mayBe() {
        generateString("1")
            .subscribe(onSuccess: { (value: String) in
                print(value)
            }, onError: { (error: Error) in
                print(error)
            }) {
                print("completed")
        }.disposed(by: disposeBag)
    }
    
    // 将Observable序列，转换成MayBe序列。
    func asMayBe() {
        Observable<String>.of("1")
            .asMaybe()
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
    }
    
    /*
     Driver 可以说是最复杂的 trait，它的目标是提供一种简便的方式在 UI 层编写响应式代码。
     
     不会产生 error 事件
     一定在主线程监听（MainScheduler）
     共享状态变化（shareReplayLatestWhileConnected）
     
     所以常用于UI操作。
     
     */
    func driver() {
        
        // 传统写法， 如果用Observable来处理UI会有几个问题需要注意： 是否是主线程
//       let  normalInuts = Maybe<String>.create {(observer: @escaping Maybe<String>.MaybeObserver) -> Disposable in
//
//            _ = self.inputField.rx.text
//                .throttle(0.3, scheduler: MainScheduler.instance)
//                .map { (value: String?) -> String in
//                    guard let value = value else {
//                        return "xx"
//                    }
//                    if value.count > 3 {
//                        observer(.error(SSTraitsError.MayBe("MayBe error")))
//                    }else {
//                        observer(.success(value))
//                    }
//                    return "xxx"
//            }
//
//            observer(.success("成功"))
//
//
//            return Disposables.create()
//        }
//
//        normalInuts.asObservable().bind(to: inputLab.rx.text).disposed(by: disposeBag)
        
        
        // throttle 的特性。
        let inputs = inputField.rx.text.orEmpty
            .asDriver()
            .map { (value: String?) -> String in
                guard let value = value else {
                    return "Option"
                }
                return "当前输入的值：\(value.hashValue)"
        }

        inputs.drive(inputLab.rx.text).disposed(by: disposeBag)
            
        
    }
    
    /*
     ControlProperty 结构体，是专门用来描述 UI 控件属性，拥有该类型的属性都是被观察者（Observable）。
     
     不会产生 error 事件
     一定在 MainScheduler 订阅（主线程订阅）
     一定在 MainScheduler 监听（主线程监听）
     
     extension Reactive where Base: UITextField {
      
         public var text: ControlProperty<String?> {
             return value
         }
      
         public var value: ControlProperty<String?> {
             return base.rx.controlPropertyWithDefaultEvents(
                 getter: { textField in
                     textField.text
             },
                 setter: { textField, value in
                     if textField.text != value {
                         textField.text = value
                     }
                }
            )
         }
     }
     */
    func controlProperty() {
        
        // 一些ui属性都是Controlproperty
        inputField.rx.text
            .bind(to: inputLab.rx.text).disposed(by: disposeBag)
        
        
    }
    
    /*
     
     1）ControlEvent结构体， 是专门用于描述 UI 所产生的事件，拥有该类型的属性都是被观察者（Observable）。

     （2）ControlEvent 和 ControlProperty 一样，都具有以下特征：

     不会产生 error 事件
     一定在 MainScheduler 订阅（主线程订阅）
     一定在 MainScheduler 监听（主线程监听）
     

     extension Reactive where Base: UIButton {
         public var tap: ControlEvent<Void> {
             return controlEvent(.touchUpInside)
         }
     }
     */
    func controlEvent() {
        
    }
    

    
}


extension SSTraitsObservableVC {
    
    func networkForPlayList(channel: String) -> Single<[String:Any]> {
        let single = Single<[String:Any]>.create { (singgleObserver: @escaping Single<[String : Any]>.SingleObserver) -> Disposable in
        
            let urlPath = "https://douban.fm/j/mine/playlist?" + "type=n&channel=\(channel)&from=mainsite"
            guard let url = URL(string: urlPath) else {
                return Disposables.create()
            }
            let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
             
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                    let result = json as? [String:Any] else {
                        singgleObserver(.error(SSTraitsError.Single(reason: "JSONSerialization error")))
                        return
                }
                
                singgleObserver(.success(result))

            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
        
        return single
    }
    
    
    func cachLocal() -> Completable {
        
        let completeble = Completable.create { (completableObserver: @escaping Completable.CompletableObserver) -> Disposable in
            
            let success = arc4random() % 2 == 0
            if success {
                completableObserver(.completed)
            }else {
                completableObserver(.error(SSTraitsError.Completable(reason: "Completable error")))
            }
            return Disposables.create()
        }
        
        return completeble
    }
    
    
    func generateString(_ inputType: String) -> Maybe<String> {
        let maybe = Maybe<String>.create { (maybeObserver: @escaping Maybe<String>.MaybeObserver) -> Disposable in
            if inputType == "0" {
                maybeObserver(.success(inputType))
            }else if inputType == "1" {
                maybeObserver(.completed)
            }else {
                maybeObserver(.error(SSTraitsError.MayBe("MayBe reason")))
            }
            return Disposables.create()
        }
        
        return maybe
    }
}
