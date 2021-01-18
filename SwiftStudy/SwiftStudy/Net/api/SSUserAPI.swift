//
//  SSNetworkAPI.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/14.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
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

///----------------------------------------------------------------------------
enum SSUserAPI {

    case login(_ telNumber: String,_ code: String)
    case mineInfo
}

extension SSUserAPI {
    
    var parames: [String: Any]? {
        switch self {
        case .login(let phone, let code):
            return [
                "telNumber":phone ,
                "code":code ]
        case .mineInfo:
            return nil
        }
    }
}


extension SSUserAPI: TargetType {
   
    var path: String {
        switch self {
        case .login:
            return "/passport/login"
        case .mineInfo:
            return "/user/get"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    
   
    
    var task: Task {
        switch self {
        case .login:
            return .requestParameters(parameters: parames!, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}



