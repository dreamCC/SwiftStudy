//
//  SSSchedulersVC.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/7/16.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/*
 （1）调度器（Schedulers）是 RxSwift 实现多线程的核心模块，它主要用于控制任务在哪个线程或队列运行。

 （2）RxSwift 内置了如下几种 Scheduler：

 CurrentThreadScheduler：表示当前线程 Scheduler。（默认使用这个）
 MainScheduler：表示主线程。如果我们需要执行一些和 UI 相关的任务，就需要切换到该 Scheduler运行。
 SerialDispatchQueueScheduler：封装了 GCD 的串行队列。如果我们需要执行一些串行任务，可以切换到这个 Scheduler 运行。
 ConcurrentDispatchQueueScheduler：封装了 GCD 的并行队列。如果我们需要执行一些并发任务，可以切换到这个 Scheduler 运行。
 OperationQueueScheduler：封装了 NSOperationQueue。
 
 */
class SSSchedulersVC: QMUICommonViewController {

    private let disposeBag = DisposeBag()
    override func initSubviews() {

        
        
        networkForPlayList(channel: "0")
            .subscribe(onSuccess: { (data: [String : Any]) in
                print(data)
            }) { (error) in
                print(error)
        }.disposed(by: disposeBag)
        
    }

    
    
}

extension SSSchedulersVC {
    
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
    
}
