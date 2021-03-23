//
//  SSNetworkManager.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/5/21.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import Moya
import Alamofire

class SSNetworkManager {
    
    typealias SuccessCallback = (Data)->()
    typealias FailCallBack    = (Error)->()
    
    static func request(_ target: TargetType, success:@escaping SuccessCallback,fail:@escaping  FailCallBack) {
        userProvider.request(target as! SSUserAPI) { (result) in
            
            switch result {
            case .success(let response):
                print(response)
                success(response.data)
            case .failure(let error):
                print(error)
                fail(error)
            }
        }
        
    }
}

