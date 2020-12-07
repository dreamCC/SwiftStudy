//
//  SSUserProvider.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/12/1.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import Moya


let userEndpointClosure: MoyaProvider<SSUserAPI>.EndpointClosure = {(target) -> Endpoint in
    
    let defaultEnpoint = MoyaProvider.defaultEndpointMapping(for: target)
    
    // 同意添加参数
    let newEnpodint = defaultEnpoint.adding(newHTTPHeaderFields: ["to":""])
    
    return newEnpodint
}

let userRequestClosure: MoyaProvider<SSUserAPI>.RequestClosure = MoyaProvider<SSUserAPI>.defaultRequestMapping


let netWorkPlugin = NetworkActivityPlugin { (type: NetworkActivityChangeType, target: TargetType) in
    
    
}

let userProvider = MoyaProvider<SSUserAPI>(endpointClosure: userEndpointClosure,
                                           requestClosure: userRequestClosure,
                                           plugins: [netWorkPlugin])
