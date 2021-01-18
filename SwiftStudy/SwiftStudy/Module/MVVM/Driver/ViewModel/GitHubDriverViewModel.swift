//
//  GitHubDriverViewModel.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/16.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import UIKit

class GitHubDriverViewModel: NSObject {
    
    // 资源控
    let repositories: Driver<[GitHubRepository]>
    
    init(searchAction: Observable<String>) {

        

        self.repositories = searchAction
            .filter{ !$0.isEmpty }
            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .flatMapLatest({ (value) -> Single<[GitHubRepository]> in
                
                print("输入值=", value)
                return Single<[GitHubRepository]>.create { (observer) -> Disposable in
                    if value == "hello" {
                        observer(.error(NSError(domain: "输入hello", code: 100, userInfo: nil)))
                    }
                    let github = GitHubRepository(JSON: ["name": value, "full_name": "\(value)+++"])
                    observer(.success([github!, github!, github!]))
                    return Disposables.create()
                }
                
                
                return gitHubApi.rx.request(.repositories(value))
                    .map { (response) -> [GitHubRepository] in
                        let responseString = try! response.mapString()
                        guard  let jsonObj = GitHubRespositores(JSONString: responseString) else {
                            return []
                        }
                        
                        print(value, jsonObj.totalCount, jsonObj.items.count, Thread.current)
                        return jsonObj.items
                    }
            }).asDriver(onErrorJustReturn: [])
    }
}
