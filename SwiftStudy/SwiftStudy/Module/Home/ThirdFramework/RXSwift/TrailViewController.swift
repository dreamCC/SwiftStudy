//
//  TrailViewController.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/8.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrailViewController: SSBaseViewController {

    @IBOutlet weak var controlBtn: UIButton!
    @IBOutlet weak var inputField: UITextField!

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }

    /*
     如果我们查看源码不难发现。其内部就是创建。Observable
     其特点发送SingEvent。也就是要么成功，要么失败。
     public enum SingleEvent<Element> {
         case success(Element)
         case error(Swift.Error)
     }
     
     任意Observable都可以通过asSinggle转换为Single。
     
     适合于网络请求。
     */
    @IBAction func single(_ sender: Any) {
        
        
        func creatSingle(value: String?)-> Single<String> {
            
            return Single<String>.create { (single) -> Disposable in
                
                single(.error(NSError(domain: "传入值为nil", code: 100, userInfo: nil)))

//                if case Optional.none = value {
//                    single(.error(NSError(domain: "传入值为nil", code: 100, userInfo: nil)))
//                }else {
//                    single(.success(value!))
//                }
                return Disposables.create()
            }
        }
        
        
        let single = creatSingle(value: "hello")
        // 发送的SingleEvent，只有两种情况。
        single.subscribe { (value) in
            print("Single 收到：", value)
        } onError: { (error) in
            print("Single 收到：", error)
        }.disposed(by: disposeBag)
        
        
        let single1 = creatSingle(value: nil)
        // 发送的SingleEvent，只有两种情况。
        single1.subscribe { (value) in
            print("Single 1 收到：", value)
        } onError: { (error) in
            print("Single 1 收到：", error)
        }.disposed(by: disposeBag)

        
       
    }
    
    /*
     completable，内部封装了Observable。发送CompletableEvent。只有两种可能，.error和.completable。
     public enum CompletableEvent {
         /// Sequence terminated with an error. (underlying observable sequence emits: `.error(Error)`)
         case error(Swift.Error)
         
         /// Sequence completed successfully.
         case completed
     }
     
     适用于只关心队列是否完成的情况。
     
     所有的observable都可以通过 asCompletable进行转换。
     */
    @IBAction func completable(_ sender: UIButton) {
        
        func createCompletable(_ value: String?) -> Completable {
            return Completable.create { (ct) -> Disposable in
            
                if let _ = value {
                    ct(.completed)
                }else {
                    ct(.error(NSError(domain: "传入值为nil", code: 100, userInfo: nil)))
                }


                return Disposables.create()
            }
        }
        
        let cp = createCompletable("优质")
        cp.subscribe {
            print("completable 收到 completed")
        } onError: { (error) in
            print("completable 收到：", error)
        }.disposed(by: disposeBag)
        
        let cp1 = createCompletable(nil)
        cp1.subscribe {
            print("completable 收到 completed")
        } onError: { (error) in
            print("completable 收到：", error)
        }.disposed(by: disposeBag)

    
        
        
    }
    
    
    /*
     MayBe对应的是MayBeEvent。
     
     public enum MaybeEvent<Element> {
         /// One and only sequence element is produced. (underlying observable sequence emits: `.next(Element)`, `.completed`)
         case success(Element)
         
         /// Sequence terminated with an error. (underlying observable sequence emits: `.error(Error)`)
         case error(Swift.Error)
         
         /// Sequence completed successfully.
         case completed
     }
     
     */
    @IBAction func maybe(_ sender: UIButton) {
      
        func createMayBe(_ value: String?) -> Maybe<String> {
            
            return Maybe<String>.create { (mb) -> Disposable in
                
                mb(.success("hello"))
                mb(.success("world"))
                mb(.completed)
                mb(.completed)
                mb(.error(NSError(domain: "错误-1", code: 100, userInfo: nil)))
                mb(.error(NSError(domain: "错误-2", code: 100, userInfo: nil)))
                return Disposables.create()
            }
        }
        
        createMayBe("enha").subscribe { (value) in
            print("value: \(value)")
        } onError: { (error) in
            print("error:", error)
        } onCompleted: {
            print("completable")
        }.disposed(by: disposeBag)
        
        /*
         输出日志：
         value: hello
         */

    }
    
    
    /// 这几个属于RxCocoa。所以更适合UI处理。
    // 我们知道，observable，如果受到error的时候，那么就会解除订阅。
    @IBAction func driver(_ sender: Any) {

        print("\ncreate-------------")
        let create = Observable<Int>.create { (observer) -> Disposable in

            DispatchQueue.global().async {
                observer.onNext(1)
                observer.onNext(12)
                observer.onError(NSError(domain: "错误", code: 100, userInfo: nil))
                observer.onNext(-1)
                observer.onCompleted()
                observer.onNext(-12)
            }

            return Disposables.create()
        }
//        create.catchErrorJustReturn(-100).subscribe { (value) in
//            print("create---:\(value)")
//        } onError: { (error) in
//            print("error: \(error)")
//        } onCompleted: {
//            print("create---: complement")
//        }.disposed(by: disposeBag)
        
        
        // 这些代码和上面是一样的。driver可以直接对error进行处理。
        print("\ndriver-------------")
        
        create.asDriver(onErrorJustReturn: -100).drive { (value) in
            print("driver收到的值：\(value)", Thread.current)
        } onCompleted: {
            print("driver---completed")
        }.disposed(by: disposeBag)

    
        
    }
    
    
    // 即可发送也可监听，UITextField就属于ControlProperty。
    @IBAction func controlProperty(_ sender: Any) {
        
        // UITextField中的text就属于ControlProperty。
        inputField.rx.text.bind(to: desLab.rx.text).disposed(by: disposeBag)
    }
    
    
    
    @IBAction func controlEvent(_ sender: UIButton) {
        
        controlBtn.rx.tap.subscribe { (_) in
            print("点击收到-----")
        } onError: { (error) in
            print("error: \(error)")
        } onCompleted: {
            print("completable")
        }.disposed(by: disposeBag)        

    }
    
}
