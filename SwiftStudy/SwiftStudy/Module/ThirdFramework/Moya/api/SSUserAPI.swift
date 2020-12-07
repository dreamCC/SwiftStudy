//
//  SSNetworkAPI.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/14.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import Moya



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



