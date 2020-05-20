//
//  SSNetwork.swift
//  SwiftStudy
//
//  Created by Zhu ChaoJun on 2020/1/10.
//  Copyright © 2020 Zhu ChaoJun. All rights reserved.
//

import Foundation
import Alamofire


// 传统封装思路。
class SSNetwork {
    static let baseUrl: String = ""
    
    let sessionMng: SessionManager
    
    static let `default` = SSNetwork()

    private init() {
        
        sessionMng = SessionManager.default
        
    }
    
    func requset(url: String, parames: Parameters, success: ((Any)->())? = nil, fail: ((Error)->())? = nil) {
        
        let allUrl = "" + url
        
        request(allUrl, method: HTTPMethod.post, parameters: parames, encoding: JSONEncoding.default)
            .responseJSON { (response) in
         
                switch response.result {
                case .success(let value):
                    success?(value)
                case .failure(let error):
                    fail?(error)
                }
        }
        
    }
    
}

// 高端封装
enum RequstRoute {
    case login(name: String, pwd: String)
    case userInfo(userId: String)
}

extension RequstRoute: URLRequestConvertible {
    
    
    static let baseUrl = "http://www.baidu.com"
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .userInfo:
            return "/userInfo"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .get
        default:
            return .post
        }
    }
    
    var parames: Parameters {
        switch self {
        case .login(name: let name, pwd: let pwd):
            return [
                "name": name,
                "pwd":pwd
            ]
        case .userInfo(userId: let userId):
            return [
                "userId": userId
            ]
            
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try RequstRoute.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(urlRequest, with: parames)
    }
}

