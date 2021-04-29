//
//  SSObservableViewModel.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2021/1/14.
//  Copyright © 2021 Zhu ChaoJun. All rights reserved.
//

import Foundation
import Moya


typealias Success = (_ response: Response) -> Void
typealias Failure = (_ error: MoyaError) -> Void
extension MoyaProvider {
    
    @discardableResult
    func request(_ target: Target,
                      callbackQueue: DispatchQueue? = .none,
                      progress: ProgressBlock? = .none,
                      success: Success?,
                      failure: Failure?) -> Cancellable {

        return request(target,
                       callbackQueue: callbackQueue,
                       progress: progress) { (result) in
            
            switch result {
            case .success(let response):
                success?(response)
            case .failure(let error):
                failure?(error)
            }
        }
    }
}

class GitHubRepositoryViewModel {

    // 资源控
    let repositories: Observable<[GitHubRepository]>
    
    init(searchAction: Observable<String>) {

        
        self.repositories = searchAction
            .filter{ !$0.isEmpty }
            .throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .flatMapLatest { (value) -> Observable<[GitHubRepository]> in
                                    
                return Observable<[GitHubRepository]>.create { (observer) -> Disposable in
                    
                  let requestCancelToken =  gitHubApi.request(.repositories(value)) { (response) in
                        
                        let responseString = try! response.mapString()
                        guard  let jsonObj = GitHubRespositores(JSONString: responseString) else {
                            return
                        }
                        
                    print(value, jsonObj.totalCount, jsonObj.items.count, Thread.current)
                        observer.onNext(jsonObj.items)
                    } failure: { (error) in
                        print(error)
                    }
                    
                    return Disposables.create {
                        requestCancelToken.cancel()
                    }
                }
                
            }
    }
    
    func getGitHubRepository(_ input: String) {
        
        
        gitHubApi.request(.repositories(input)) { (response) in
            let responseString = try! response.mapString()
            guard  let jsonObj = GitHubRespositores(JSONString: responseString) else {
                
                return
            }
            
            print(jsonObj.totalCount, jsonObj.items.count, jsonObj.ag)
            
        } failure: { (error) in
            print(error)
        }

    }
}



