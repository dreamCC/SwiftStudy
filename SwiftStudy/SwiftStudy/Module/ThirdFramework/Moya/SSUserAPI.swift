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
    
    var method: Moya.Method {
        return .post
    }
    
    var headers: [String : String]? {
        return nil
    }
}

// 增加私有方法
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
    
}

let networkProvider = MoyaProvider<SSUserAPI>()
// 多个TargetType的时候。
let multiProvider = MoyaProvider<MultiTarget>()

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

//MARK: -----------
enum SSHomeAPI {
   
    var parameters: [String:Any] {
           switch self {
           case let .list(page: page, token: token):
               return ["page":page, "token": token]
           case .info(id: let id):
               return ["id": id]
           }
       }
    
    case list(page: String, token: String)
    case info(id: String)
}

extension SSHomeAPI: TargetType {
   
    
    var path: String {
        if case .list = self {
            return "/list"
        }
        if case .info = self {
            return "/info"
        }
        return ""
    }
       
    
    var task: Task {
        switch self {
        case .list:
            
            return .requestPlain
        default:
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
       
    
    
}

