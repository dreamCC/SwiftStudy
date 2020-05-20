//
//  SSNetworkAPI.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/14.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import UIKit
import Moya

extension TargetType {
    
    var baseURL: URL {
        return URL(string: "http://39.100.146.105:7001")!
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
}

// 增加私有方法
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    
}

let networkProvider = MoyaProvider<SSNetworkAPI>()
// 多个TargetType的时候。
let multiProvider = MoyaProvider<MultiTarget>()

enum SSNetworkAPI {

    case login(telNumber: String, code: String)
    case mineInfo
}

extension SSNetworkAPI {
    
    var parames: [String: Any]? {
        switch self {
        case .login(telNumber: let phone, code: let code):
            return [
                "telNumber":phone ,
                "code":code ]
        case .mineInfo:
            return nil
        }
    }
}


extension SSNetworkAPI: TargetType {
   
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

